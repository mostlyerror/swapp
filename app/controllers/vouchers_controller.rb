class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show created ]

  def new
    if @swap
      @voucher = Voucher.new
      supply = RoomSupply.vouchers_remaining_today(@swap)
      @disabled = []
      @motels = Motel.all.reduce({}) do |memo, motel|
        name = "#{motel.name} (#{supply[motel.id]})"
        if supply[motel.id].to_i <= 0
          @disabled << motel.id
        end
        memo.merge(Hash[name, motel.id])
      end
      @client = Client.find(params['client_id'])
    end
  end

  def create
    @motels = Motel.all
    @client = Client.find(params['client']['id'])

    @voucher = Voucher.new(
      user: current_user,
      client_id: params['client']['id'],
      motel_id: params['voucher']['motel_id'],
      check_in: params['voucher']['check_in'],
      check_out: params['voucher']['check_out'],
      swap: @swap
    )

    if !@voucher.save
      if @voucher.errors[:client_id].include? "has already been taken"
        @existing_voucher = Swap.current.vouchers.find_by(client: @voucher.client)
      end
      return render :new
    end

    redirect_to action: :created, id: @voucher.id
  end

  def created

  end

  def show
  end

  private

    def set_voucher
      @voucher = Voucher.find(params[:id])
    end
end
