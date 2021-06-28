
class Admin::UsersController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:update]
  # TODO: move the users list from caseworker side users controller to here.
  # def index
  # end

  def update
    puts 'updating...'
    ap params


    user_id = params['id'].to_i
    if user_id != params['user']['id'].to_i
      render json: {
        errors: ['user ID in URL does not match user ID in payload']
      }, status: 422
    end

    user = User.find(user_id)
    user.assign_attributes(user_params)
    if user.save
      render json: user, status: :ok
    else
      render json: {
        errors: user.errors.as_json(full_messages: true)
      }, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end