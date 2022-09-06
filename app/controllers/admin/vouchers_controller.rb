class Admin::VouchersController < Admin::BaseController
  def void
    voucher = Voucher.find(params[:id])
    voucher.void!(current_user)
    redirect_to voucher_path(voucher)
  end
end
