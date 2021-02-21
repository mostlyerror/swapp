class Admin::BaseController < ApplicationController
  layout 'admin/admin'
  before_action :authenticate_user!
  before_action do 
    if !current_user.admin?
      redirect_to new_user_session_path
    end
  end
end
