class BookingsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_room   

  def create
    @booking = current_user.bookings.new(booking_params)
    @booking.room_id = @room.id
    
    if @booking.save
      payment = Payment.new(payment_params)
      payment.user_id = current_user.id
      payment.booking_id = @booking.id

      if payment.save
        @booking.update(
            transaction_id: payment.stripe_payment_id
            payment_method: payment.paymet_method
            payment_status: payment.payment_status
        )

        render json: {booking: @booking, payment: payment}, status: :ok
      else
        @booking.destroy
        render json: {error: payment.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error: @booking.errors.full_messages}, status: :unprocessable_entity   
    end
  end
  
  private

  def set_room
    @room = Room.find_by(id: params[:room_id])
    render json: { error: "Room not found" }, status: :not_found unless @room
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date, :total_prcie, :gst)
  end

  def payment_params
    params.require(:payment).permit(:amount, :paymet_method, :payment_status, :paid_at, :stripe_payment_id, :stripe_checkout_url)
  end

end
