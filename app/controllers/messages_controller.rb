class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user!, :only => "sms"
  skip_before_action :authenticate_user!

  def sms
    body = params[:Body]&.strip&.upcase
    from = params[:From]
    render xml: HotlineResponse.new(body, from).response
  end

  def test
    @user = User.last
    MessageMailer.with(user: @user, message: OpenStruct.new(subject: 'hi', body: 'i miss you')).email.deliver_now!
  end
end
