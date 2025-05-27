class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:user_id])
  end

  def send_welcom_email
    user = User.find(params[:user_id])
    UserMailer.welocme_email(user).deliver
  end

  def user_profile
    profile = current_user
    render json: {profile: profile}, status: :ok
  end

  def edit_user_profile
    profile = current_user
    if profile.update(profile_params)
      render json: {user: profile, message: "profile was updated successfully"}, status: :ok
    else
      render json: {errors: profile.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def profile_params
   params.require(:user).permit(:name, :address, :mobile_number)
  end
end