# == Schema Information
# Schema version: 20211103053452
#
# Table name: clients
#
#  id                       :bigint           not null, primary key
#  banned                   :boolean          default(FALSE)
#  date_of_birth            :date
#  email                    :string
#  ethnicity                :string
#  family_members           :jsonb
#  first_name               :string           not null
#  force_intake             :boolean          default(FALSE)
#  gender                   :string
#  last_name                :string           not null
#  phone_number             :string
#  race                     :jsonb
#  veteran                  :boolean
#  veteran_discharge_status :string
#  veteran_military_branch  :string
#  veteran_separation_year  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def index
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)
  end

  def search
    results = ClientSearch.search(params[:q])
    render json: results
  end

  def show
    @client = Client.find(params[:id])
    @existing_voucher = @client.current_voucher
    @editing = params[:editing]
  end

  def update
    @client = Client.find(params[:id])
    client_params = params.require(:client).permit!

    if client_params["date_of_birth"].blank?
      client_params["date_of_birth"] = "1600-01-01"
    end

    client_params[:race] = client_params[:race].reject { |r| r == "0" }.sort

    if @client.update(client_params)
      return redirect_to @client
    end

    render :show
  end

  # POST /clients
  # guests form sends xhr request to this endpoint
  # new clients are normally created in conjunction with intakes in intakes#create
  def create
    client_params = params.require("client").permit(:first_name, :last_name, :date_of_birth)
    if client_params["date_of_birth"].blank?
      client_params["date_of_birth"] = "1600-01-01"
    end

    client = Client.new(client_params.merge(force_intake: true))
    if client.save
      return render json: client, status: :ok
    end

    render json: client.errors.full_messages, status: :unprocessable_entity
  end
end
