class Admin::HomeController < Admin::BaseController
  def users
    @users = User.all.order('id asc').map do |user|
      roles = []
      roles << 'intake' if user.intake_user?
      roles << 'admin' if user.admin_user?
      roles << 'hotel' if user.hotel_user?

      {
        id: user.id, 
        active: user.active, 
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        roles: roles.sort
      }
    end
  end

  def index
    @vouchers = Voucher.order(created_at: :desc).limit(20)
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)

    if @swap
      @vouchers_remaining_today = RoomSupply.vouchers_remaining_today(@swap)
      @num_vouchers_remaining_today = RoomSupply.num_vouchers_remaining_today(@swap)
      @supply = RoomSupply.by_hotel(@swap)  
      @hotel_map = Hotel.all.pluck(:id, :name).to_h
    end
  end
end
