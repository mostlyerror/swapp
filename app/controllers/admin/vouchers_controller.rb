class Admin::VouchersController < Admin::BaseController
  def void
    Vouchers::Void.run(params: params.to_h, user: current_user)
  end
end
