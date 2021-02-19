class Admin::BaseController < ApplicationController
  layout 'admin/admin'
  skip_before_action :authenticate_user!
end
