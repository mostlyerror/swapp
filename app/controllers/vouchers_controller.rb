class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show created ]

  def new
    @client = Client.find(params['client_id'])
    if @swap
      @existing_voucher = Swap.current.vouchers.find_by(client: @client)
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
    end
  end

  def create
    @client = Client.find(params['client']['id'])
    @motels = Motel.all
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
        @existing_voucher = Swap.current.vouchers.find_by(client_id: @voucher.client_id)
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
    def set_existing_voucher
      if @swap
        @existing_voucher = @swap.vouchers.find_by(client_id: params[:client_id])
      end
    end

    def set_voucher
      @voucher = Voucher.find(params[:id])
    end
end
