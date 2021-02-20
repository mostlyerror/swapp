class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show ]

  def new
    @voucher = Voucher.new
    @swap = SwapPeriod.current
    @motels = Motel.all
    @client = Client.find(params['client_id'])
  end

  def create
    @voucher = Voucher.create!(
      user: current_user,
      client_id: params['client']['id'],
      motel_id: params['voucher']['motel_id'],
      check_in: params['voucher']['check_in'],
      check_out: params['voucher']['check_out'],
      swap_period: SwapPeriod.current
    )

    redirect_to @voucher
  end

  def show
  end

  private

    def set_voucher
      @voucher = Voucher.find(params[:id])
    end
end
