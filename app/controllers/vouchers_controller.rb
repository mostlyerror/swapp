class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show created ]

  def new
    @swap = Swap.current
    if @swap
      @voucher = Voucher.new
      @motels = Motel.all.pluck(:name, :id)
      @supply = RoomSupply.by_motel(@swap)
      @client = Client.find(params['client_id'])
    end
  end

  def create
    @motels = Motel.all
    @client = Client.find(params['client']['id'])

    @voucher = Voucher.new(
      user: current_user,
      client_id: params['client']['id'],
      motel_id: params['voucher']['motel_id'],
      check_in: params['voucher']['check_in'],
      check_out: params['voucher']['check_out'],
      swap: @swap
    )

    if !@voucher.save
      if @voucher.errors[:client_id].include? "has already been taken"
        @existing_voucher = Swap.current.vouchers.find_by(client: @voucher.client)
      end
      return render :new
    end

    redirect_to action: :created, id: @voucher.id
  end

  def created
  end

  def show
  end

  private

    def set_voucher
      @voucher = Voucher.find(params[:id])
    end
end
