class Admin::BaseController < ApplicationController
  layout 'admin/admin'
  around_action :use_logidze_responsible, only: %i[create update]

  def use_logidze_responsible(&block)
    Logidze.with_responsible(current_user&.id, &block)
  end
end
