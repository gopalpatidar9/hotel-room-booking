class RoomsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_hotel
  before_action :set_room , only: [:perform_simple_job, :show, :update, :destroy]

  def create
    if current_user.role == "host"
      @room = @hotel.rooms.new(room_params)
      if @room.save
        render json: {message: "Room was succsefully created", room: @room}, status: :ok
      else
        render json: {errors: @room.full_messages}, status: :unprocessable_entity  
      end
    end  
  end
  
  def show
    if @room
      render json: {room: @room}
    else
      render json: {error: "Room not found"}, status: :not_found
    end
  end

  def update
    if @room.update(room_params)
      render json: {message: "Room updated sucessfuly"}, status: :ok
    else
      redner json: {erros: @room.errros.full_messages}, status: :unprocessable_entity
    end   
  end

  def destroy
    if @room.destroy
      render json: {message: "#{@room.title} Deleted sucsessfully"}, status: :ok
    else
      render json: {error: @room.erros.full_messages}, status: :unprocessable_entity
    end
  end

  def perform_simple_job
    @user_name = @room.hotel.user.name
    # puts "simple job performed by #{@user_name}"
    SimpleJob.set(wait: 20.seconds).perform_later(@user_name , "first_room", 1111)
  end

  private

  def set_hotel
    @hotel = Hotel.find_by(id: params[:hotel_id])
    if @hotel.nil?
      render json: {error: "Hotel not found"}
    end
  end

  def set_room
    @room = Room.find_by(id: params[:room_id])
    if @room.nil?
      render json: {error: "Room not found" }, status: :not_found
    end
  end

  def room_params
    params.require(:room).permit(
      :room_type, :title, :description, :num_guests,
      :num_rooms, :num_beds, :num_baths, :price_per_night,
      :self_check_in, :parking, :kitchen, :washer, :dryer,
      :dishwasher, :wifi, :tv, :bathroom, :bathroom_essentials,
      :coffe_maker, :hair_dryer, :location, :room_num
    )
  end
end
