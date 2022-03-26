class TwilioController < ApplicationController
  # we need to skip CSRF detection to receive POST from other systems
  skip_before_action :verify_authenticity_token

  # we don't have a current_user in this context
  skip_before_action :authenticate_user!

  def sms
    logger.info('Incoming SMS Message')
    logger.info('params:')
    logger.info(params)

    # We _could_ match the incoming SMS phone number to existing client accounts
    logger.info params[:Body]
    logger.info params[:From]

    body = params[:Body]&.strip&.upcase
    from = params[:From]

    render xml: HotlineResponse.new(body, from).response
  end
end
