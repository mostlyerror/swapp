class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, :only => "sms"

  def sms
    body = params[:Body]&.strip&.upcase
    from = params[:From]
    render xml: HotlineResponse.new(body, from).response
  end
end
 
