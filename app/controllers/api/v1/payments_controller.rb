class Api::V1::PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:create]
  before_action :set_payment, only: [:show]
  before_action :set_room, only: [:show_room_payments]
  
  def index
    if current_user.role == "guest"
      payments_history = current_user.payments
      if payments_history.exists?
        render json: { payments: payments_history }, status: :ok
      else  
        render json: { message: "No payments." }, status: :ok
      end
    else  
      render json: {error: "You're not authorized to view these payments."}, status: :unauthorized
    end
  end
  
  def show
    if current_user.role == "guest" && @payment.user_id == current_user.id 
      render json: {payment: @payment}, status: :ok
    else
      render json: {error: "your not authorized to view this payment"}, status: :unauthorized
    end
  end

  def create
    if @booking.user_id == current_user.id
      payment = current_user.payments.new(payment_params.merge(booking: @booking))
      if payment.save
        @booking.update(
          payment_method: payment.pay_method,
          payment_status: payment.pay_status,
          transaction_id: payment.stripe_payment_id
        )
        render json: { payment: payment }, status: :ok  
      else
        render json: { error: payment.errors.full_messages }, status: :unprocessable_entity 
      end
    else  
      render json: { error: "Your not authrized for paying this payment"}, status: :unauthorized
    end
  end

  def show_room_payments
    if current_user.role == "host" && @room.hotel.user_id == current_user.id
      room_bookings = Booking.where(room_id: @room.id)
      room_payments = Payment.where(booking_id: room_bookings.select(:id))

      if room_payments.exists?
        render json: { payments: room_payments }, status: :ok
      else
        render json: {message: "No payments for this room."}, status: :ok
      end
    else  
      render json: {error: "You're not authorized to view these payments."}, status: :unauthorized
    end
  end

  private

  def set_booking
    @booking = Booking.find_by(id: params[:booking_id])
    unless @booking
      render json: { error: "Booking not found" }, status: :not_found
    end
  end

  def set_payment 
    @payment = Payment.find_by(id: params[:id])
    unless @payment  
      render json: {error: "Payment not found"}, status: :not_found
    end
  end

  def set_room
    @room = Room.find_by(id: params[:room_id])
    unless @room 
      render json: {error: "Room not found"}, status: :not_found
    end
  end

  def payment_params
    params.require(:payment).permit(:pay_method, :stripe_payment_id, :stripe_checkout_url)
  end
end
