class Api::V1::RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:show_hotel_rooms, :create, :show, 
    :update, :destroy]
  before_action :set_hotel, only: [:show_hotel_rooms, :create, :update, :destroy]
  before_action :set_room , only: [:perform_simple_job, :show, :update, :destroy]

  def index
    rooms = Room.all 
    if rooms.exists?
      render json: {roomes: rooms}, status: :ok 
    else
      render json: {message: "No Roomes"}, status: :not_found
    end
  end

  def show_hotel_rooms
    if current_user.role == "host" && @hotel.user_id == current_user.id 
      hotel_rooms = @hotel.rooms
      if hotel_rooms.exists?
        render json: {rooms: hotel_rooms}, status: :ok 
      else
        render json: {message: "No rooms for this Hotel"}, status: :not_found
      end
    else
      render json: {error: "Your not authorized to view this rooms"}, status: :unauthorized
    end  
  end

  def create
    if current_user.role == "host" && @hotel.user_id == current_user.id
      room = @hotel.rooms.new(room_params)
      if room.save
        render json: {message: "Room was succsefully created", room: room}, status: :ok
      else
        render json: {errors: room.full_messages}, status: :unprocessable_entity  
      end
    else  
      render json: {error: "Your not authorized to create this room"}, status: :unauthorized
    end  
  end
  
  def show
    render json: {room: @room}, status: :ok
  end

  def update
    if current_user.role == "host" && @room.hotel.user_id == current_user.id
      if @room.update(room_params)
        render json: {message: "Room updated sucessfuly", room: @room}, status: :ok
      else
        redner json: {erros: @room.errros.full_messages}, status: :unprocessable_entity
      end
    else 
      render json: {error: "Your not authorized to edit this room"}, status: :unauthorized  
    end     
  end

  def destroy
    if current_user.role == "host" && @room.hotel.user_id == current_user.id
      if @room.destroy
        render json: {message: "#{@room.title} Deleted sucsessfully"}, status: :ok
      else
        render json: {error: @room.erros.full_messages}, status: :unprocessable_entity
      end
    else 
      render json: {error: "Your not authrized to Delete this room"}, status: :unauthorized
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
      render json: {error: "Hotel not found"}, status: :not_found
    end
  end

  def set_room
    @room = Room.find_by(id: params[:id])
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
