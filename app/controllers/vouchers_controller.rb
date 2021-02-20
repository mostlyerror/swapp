class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show ]

  def new
    @voucher = Voucher.new
    @swap = SwapPeriod.current
    @motels = Motel.all
    @client = Client.find(params['client_id'])
  end

  def create
    client = Client.find(params['client']['id'])
    motel = Motel.find(params['voucher']['motel_id'])
    check_in = Date.new *%w(1 2 3).map {|e| params["voucher"]["check_in(#{e}i)"].to_i }
    check_out = Date.new *%w(1 2 3).map {|e| params["voucher"]["check_out(#{e}i)"].to_i }

    @voucher = Voucher.create!(
      user: current_user,
      client: client,
      motel: motel,
      check_in: check_in,
      check_out: check_out,
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
