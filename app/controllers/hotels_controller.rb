class HotelsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :authenticate_user!
  before_action :set_hotel, only: [:update, :show, :destroy]

  def index
    @hotels = current_user.hotels
    render json: {hotels: @hotels}
  end

  def create
    @hotel = current_user.hotels.new(hotel_params)
    if @hotel.save
      render json: {message: "Hotel Created succesfully!", hotel: @hotel}, status: :created
    else
      render json: {errors: @hotel.errors.full_messages}, status: :unprocessable_entity  
    end
  end
  
  def update
    if @hotel.update(hotel_params)
      render json: {message: "Hotel Updated successfully!", hotel: @hotel}, status: :ok
    else
      render json: {errors: @hotel.errors.full_messages}, status: :unprocessable_entity  
    end
  end

  def show
    if @hotel
      render json: @hotel
    else
      render json: {errors: "Hotel not found"}, status: :not_found  
    end
  end

  def destroy
    if @hotel.destroy
      render json: {message: "hotel deleted successfully"}, status: :ok
    else
      render json: {errors: @hotel.errors.full_messages}, status: :unprocessable_entity  
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find_by(id: params[:id])
    if @hotel.nil?
      render json: {error: "Hotel not found or you are not authorized to update this hotel.", status: :not_found}
    end
  end

  def hotel_params
    params.require(:hotel).permit(:hotel_name, :loaction, :description)
  end
end


