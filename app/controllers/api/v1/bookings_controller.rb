class Api::V1::BookingsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_room, only: [:create, :cancle_booking, :show_room_booking]   
  before_action :set_booking, only: [:show, :cancle_booking]

  def index
    if current_user.role == "guest"
      bookings = current_user.bookings
      if bookings.exists?
        render json: {bookings: bookings}, status: :ok 
      else  
        render json: {message: "No Bookings"}, status: :ok  
      end
    else  
      render json: {error: "your not authrized to view this Bookings"}, status: :unauthorized  
    end
  end

  def create
    booking = current_user.bookings.new(booking_params)
    booking.room_id = @room.id
    if booking.save
      render json: {booking: booking}, status: :ok
    else
      render json: {error: booking.errors.full_messages}, status: :unprocessable_entity   
    end
  end
  
  def show
    if current_user.role == "guest" && current_user.id == @booking.user_id
      render json: {booking: @booking}, status: :ok 
    else
      render json: {error: "Your not authrized to view this Bookingg"}, status: :unauthorized
    end
  end
  
  def cancle_booking
    if current_user.id == @booking.user_id
      payment = Payment.fin_by(stripe_payment_id: @booking.transaction_id)
      if @booking.destroy
        render json: {message: 'Booking was cancled'}, status: :ok
      else 
        render json: {error: @booking.errors.full_messages}, status: :unprocessable_entity  
      end
    else  
      render json: {error: "Your not authrized to cancle this Booking"}, status: :unauthorized  
    end  
  end

  def show_room_booking
    if current_user.role == "host" && current_user.id == @room.hotel.user_id
      room_bookings = @room.bookings
      if room_bookings.present?
        render json: {bookings: room_bookings}, status: :ok
      else
        render json: {message: "No Bookings for this Room"}, status: :ok
      end
    else  
      render json: { error: "Your not authrized to view this Bookings" }, status: :unauthorized
    end
  end

  private

  def set_booking
    @booking = Booking.find_by(params[:id])
    unless @booking
      render json: {error: "Booking not found"}, status: :not_found  
    end
  end

  def set_room
    @room = Room.find_by(id: params[:room_id])
    render json: { error: "Room not found" }, status: :not_found unless @room
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date, :payment_method)
  end
end 
