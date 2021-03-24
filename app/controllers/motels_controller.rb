class MotelsController < ApplicationController
  def index
    @vouchers = Voucher.all
  end

  def show
    @client = Client.find(params[:id])
  end
end
