class Api::V1::BookingsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_room   
  before_action :set_booking, only: [:show, :cancle_booking]

  def index
    if current_user.id 
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    @booking.room_id = @room.id
    if @booking.save
      render json: {booking: @booking}, status: :ok
    else
      render json: {error: @booking.errors.full_messages}, status: :unprocessable_entity   
    end
  end
  
  def show
    if current_user.role == "guest" && current_user.id == @booking.user_id
      render json: {booking: @booking}, status: :ok 
    else
      render json: {error: "Your not authrized"}
    end
  end
  
  def cancle_booking
    if current_user.id == @booking.user_id
      @payment = Payment.fin_by(stripe_payment_id: @booking.transaction_id)
      if @booking.destroy
        render json: {message: 'Booking was cancled'}
      else 
        render json: {error: @booking.errors.full_messages}  
      end
    else  
      render json: {error: "Your not authrized"}  
    end  
  end



  private

  def set_booking
    @booking = Booking.find(perams[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Booking not found"}, status: :not_found
    return
  end

  def set_room
    @room = Room.find_by(id: params[:room_id])
    render json: { error: "Room not found" }, status: :not_found unless @room
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date, :payment_method)
  end
end 
