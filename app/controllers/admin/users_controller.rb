
class Admin::UsersController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:update]
  # TODO: move the users list from caseworker side users controller to here.
  # def index
  # end

  def update
    user_id = params['id'].to_i
    if user_id != params['user']['id'].to_i
      render json: {
        errors: ['user ID in URL does not match user ID in payload']
      }, status: 422
    end

    user = User.find(user_id)
    user.active = params['active']
    user.first_name = params['first_name']
    user.last_name = params['last_name']
    user.email = params['email']
    params['roles'].each do |role|
      user.admin_user = true if role == "admin"
      user.intake_user = true if role == "intake"
      user.hotel_user = true if role == "hotel"
    end

    if user.save
      render json: user, status: :ok
    else
      render json: {
        errors: user.errors.as_json(full_messages: true)
      }, status: 422
    end
  end
end