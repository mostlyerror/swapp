class Admin::UsersController < Admin::BaseController
  skip_before_action :verify_authenticity_token, only: [:update]

  def index
    @users = User.all.order("id asc").map do |user|
      roles = []
      roles << "intake" if user.intake_user?
      roles << "admin" if user.admin_user?
      roles << "hotel" if user.hotel_user?

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

  def update
    user_id = params["id"].to_i
    if user_id != params["user"]["id"].to_i
      render json: {
        errors: ["user ID in URL does not match user ID in payload"]
      }, status: :unprocessable_entity
    end

    user = User.find(user_id)
    user.active = params["active"]
    user.first_name = params["first_name"]
    user.last_name = params["last_name"]
    user.email = params["email"]
    user.admin_user = "admin".in? params["roles"]
    user.intake_user = "intake".in? params["roles"]
    user.hotel_user = "hotel".in? params["roles"]

    if user.save
      UserNotifierMailer.send_user_update_email(user).deliver
      render json: user, status: :ok
    else
      render json: {
        errors: user.errors.as_json(full_messages: true)
      }, status: :unprocessable_entity
    end
  end
end
