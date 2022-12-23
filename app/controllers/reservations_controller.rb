class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  # GET /reservations
  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  # GET /reservations/code
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  # POST /reservation
  def payload
    dir = ReservationDirector.new(params)
    
    guest = dir.get_guest
    reservation = dir.get_reservation

    ActiveRecord::Base.transaction do
      guest.save
      reservation.guest = guest
      reservation.save
    end

    render status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find_by_id(params[:id]) || Reservation.find_by_code(params[:code])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:code, :start_date, :end_date, :nights, :adults, :children, :infants, :status, :guest_id, :currency, :payout_price, :security_price)
    end
end
