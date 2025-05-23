class Api::V1::PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking

  def create
    if current_user.id == @booking.user_id
      @payment = current_user.payments.new(payment_params.merge(booking: @booking))
      if @payment.save
        @booking.update(
          payment_method: @payment.pay_method,
          payment_status: @payment.pay_status,
          transaction_id: @payment.stripe_payment_id
        )
        render json: { payment: @payment }, status: :ok  
      else
        render json: { error: @payment.errors.full_messages }, status: :unprocessable_entity 
      end
    else  
      render json: { error: "Your not authrized"} 
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Booking not found" }, status: :not_found
  end

  def payment_params
    params.require(:payment).permit(:pay_method, :stripe_payment_id, :stripe_checkout_url)
  end
end
