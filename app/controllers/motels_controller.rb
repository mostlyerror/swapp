class MotelsController < ApplicationController
  def index
    @vouchers = Voucher.all
  end
end
