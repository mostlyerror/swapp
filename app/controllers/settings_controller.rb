class SettingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    user = User.find(params[:id])
    settings_params = params.require(:setting).permit(
      :show_swap_panel
    )
    user.update(settings_params)
    head 200
  end
end
