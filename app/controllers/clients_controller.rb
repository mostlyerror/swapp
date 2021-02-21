class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show ]
  # skip_before_action :set_swap_current, only: %[  ]

  # GET /clients or /clients.json
  def index
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)
  end

  # GET /clients/1 or /clients/1.json
  def show
    @existing_voucher = Swap.current&.vouchers&.find_by(client: @client)
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end
end
