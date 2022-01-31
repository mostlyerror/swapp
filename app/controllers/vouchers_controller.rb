# == Schema Information
# Schema version: 20211223223312
#
# Table name: vouchers
#
#  id                        :bigint           not null, primary key
#  check_in                  :date             not null
#  check_out                 :date             not null
#  guest_ids                 :integer          default([]), is an Array
#  notes                     :text
#  num_adults_in_household   :integer
#  num_children_in_household :integer
#  number                    :string
#  voided_at                 :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  client_id                 :bigint           not null, indexed, indexed => [swap_id]
#  hotel_id                  :bigint           not null, indexed
#  swap_id                   :bigint           indexed => [client_id], indexed
#  user_id                   :bigint           not null, indexed
#  voided_by_id              :bigint           indexed
#
# Indexes
#
#  index_vouchers_on_client_id              (client_id)
#  index_vouchers_on_client_id_and_swap_id  (client_id,swap_id)
#  index_vouchers_on_hotel_id               (hotel_id)
#  index_vouchers_on_swap_id                (swap_id)
#  index_vouchers_on_user_id                (user_id)
#  index_vouchers_on_voided_by_id           (voided_by_id)
#
# Foreign Keys
#
#  fk_rails_1a4d6b99f0  (swap_id => swaps.id)
#  fk_rails_1ea81e504c  (hotel_id => hotels.id)
#  fk_rails_35b9b0ce9d  (client_id => clients.id)
#  fk_rails_3e6ca7b204  (user_id => users.id)
#  fk_rails_8c1008a5cb  (voided_by_id => users.id)
#
class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[show created]
  before_action :set_voucher_supply_for_hotel_dropdown, only: %i[new create]

  def new
    @client = Client.find(params[:client_id])
    @voucher = Voucher.new(client: @client)

    if @swap
      @short_intake = ShortIntake.new(client: @client, user: current_user)
      @existing_voucher = @swap.vouchers.active.find_by(client: @client)
    end
  end

  def create
    Voucher.transaction do
      client_params = voucher_params[:client]
      @client = Client.find(client_params[:id])
      @voucher = Voucher.new(client: @client, swap: @swap, issuer: current_user)

      if !@client.update(
           phone_number: client_params[:phone_number],
           email: client_params[:email],
         )
        return render :new
      end

      short_intake_params = voucher_params[:short_intake]
      @short_intake = ShortIntake.new(short_intake_params)
      @short_intake.why_not_shelter =
        short_intake_params[:why_not_shelter].reject { |r| r == '0' }
      @short_intake.client = @client
      @short_intake.user = current_user
      @short_intake.swap = @swap
      @short_intake.vehicle = !!short_intake_params[:vehicle]

      return render :new if !@short_intake.save

      @voucher.assign_attributes(
        hotel_id: voucher_params[:hotel_id],
        check_in: voucher_params[:check_in],
        check_out: voucher_params[:check_out],
        num_adults_in_household: voucher_params[:num_adults_in_household],
        num_children_in_household: voucher_params[:num_children_in_household],
        guest_ids: voucher_params[:guest_ids],
      )

      @voucher.validate

      # client has already received a voucher for the current swap period?
      if @voucher.errors[:client_id].include? 'has already been taken'
        @existing_voucher =
          @swap.vouchers.find_by(client_id: @voucher.client_id)
        return render :new
      end

      return render :new if !@voucher.save
    end

    redirect_to action: :created, id: @voucher.id
  end

  def created; end

  def send_voucher
    voucher = Voucher.find(params[:id])

    if params[:commit] == 'E-mail'
      VoucherMailer.with(voucher: voucher).voucher_email.deliver_now
    elsif params[:commit] == 'Text/SMS'
      VoucherTexter.send_sms(voucher, ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
    end
  end

  def show; end

  private

  def voucher_params
    params
      .require(:voucher)
      .permit(
        :check_in,
        :check_out,
        :hotel_id,
        :guests,
        guest_ids: [],
        client: %i[id phone_number email],
        short_intake: [
          :where_did_you_sleep_last_night,
          :what_city_did_you_sleep_in_last_night,
          { why_not_shelter: [] },
          :pets,
          :vehicle,
          :identification,
          :bus_pass,
          :king_soopers_card,
        ],
      )
  end

  def set_voucher
    @voucher = Voucher.find(params[:id])
  end

  def set_voucher_supply_for_hotel_dropdown
    @client = Client.find(params[:client_id] || voucher_params[:client][:id])
    if @swap
      supply = RoomSupply.vouchers_remaining_today(@swap)
      @disabled = @client.flagged_hotels.pluck(:id).to_set
      @hotels =
        Hotel
          .active
          .reduce({}) do |memo, hotel|
            name = "#{hotel.name} (#{supply[hotel.id]})"
            @disabled << hotel.id if supply[hotel.id].to_i <= 0
            memo.merge({ name => hotel.id })
          end
    end
  end
end
