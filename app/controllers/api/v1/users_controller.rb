class Api::V1::UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def send_welcom_email
    @user = User.find(params[:user_id])
    UserMailer.welocme_email(@user).deliver
  end
end