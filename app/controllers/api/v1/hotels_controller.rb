class Api::V1::HotelsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :authenticate_user!
  before_action :set_hotel, only: [:update, :show, :destroy]

  def index
    if current_user.role == "host"
      hotels = current_user.hotels
      if hotel.exists?
        render json: { hotels: hotels }, status: :ok
      else
        render json: { messgage: "No Hotels"}, status: :ok
    end  
  end

  def create
    if current_user.role == "host"
      hotel = current_user.hotels.new(hotel_params)
      if hotel.save
        render json: {message: "Hotel Created succesfully!", hotel: hotel}, status: :created
      else
        render json: {errors: hotel.errors.full_messages}, status: :unprocessable_entity  
      end
    else 
      render json: {error: "yor unothorized for create hotel"}, status: :unprocessable_entity
    end
  end
  
  def update
    if current_user.role == "host" && @hotel.user_id == current_user.id
      if @hotel.update(hotel_params)
        render json: {message: "Hotel Updated successfully!", hotel: @hotel}, status: :ok
      else
        render json: {errors: @hotel.errors.full_messages}, status: :unprocessable_entity  
      end
    else  
      render json: {error: "Your not authorized to edit this Hotel"}, status: :unauthorized  
    end  
  end

  def show
    if current_user.role == "host" && @hotel.user_id == current_user.id
      render json: {hotel: @hotel}, status: :ok
    else
      render json: {errors: "Hotel not found"}, status: :not_found  
    end
  end

  def destroy
    if current_user.role == "host" && current_user.id == @hotel.user_id
      if @hotel.destroy
        render json: {message: "hotel deleted successfully"}, status: :ok
      else
        render json: {errors: @hotel.errors.full_messages}, status: :unprocessable_entity  
      end
    else 
      render json: {error: "Your not authrized to Delete this Hotel"}, status: :unauthorized
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find_by(id: params[:id])
    if @hotel.nil?
      render json: {error: "Hotel not found", status: :not_found}
    end
  end

  def hotel_params
    params.require(:hotel).permit(:hotel_name, :loaction, :description, :city, :country, :state)
  end
end


