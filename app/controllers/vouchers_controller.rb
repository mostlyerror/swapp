class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show ]

  def new
    @voucher = Voucher.new
    @swap = SwapPeriod.current
    @motels = Motel.all
    @client = Client.find(params['client_id'])
  end

  def create
    @swap = SwapPeriod.current
    @motels = Motel.all
    @client = Client.find(params['client']['id'])

    @voucher = Voucher.new(
      user: current_user,
      client_id: params['client']['id'],
      motel_id: params['voucher']['motel_id'],
      check_in: params['voucher']['check_in'],
      check_out: params['voucher']['check_out'],
      swap_period: SwapPeriod.current
    )

    if !@voucher.save
      if @voucher.errors[:client_id].include? "has already been taken"
        @existing_voucher = SwapPeriod.current.vouchers.find_by(client: @voucher.client)
      end
      return render :new
    end

    redirect_to @voucher
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
