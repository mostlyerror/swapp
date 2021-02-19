class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show ]

  def new
    @client = Client.find(params['client_id'])
  end

  def show
  end

  private

    def set_voucher
      @voucher = Voucher.find(params[:id])
    end
end
