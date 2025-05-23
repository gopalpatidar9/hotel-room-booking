class Users::SessionsController < DeviseTokenAuth::SessionsController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  respond_to :json

  private

  def render_create_success
    token = @resource.create_new_auth_token
    response.headers.merge!(token)

    render json: {
      message: "Logged in successfully.",
      user: @resource.as_json(only: [:id, :email, :name, :mobile_number, :address, :role]),
      token: token
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: { message: "Couldn't find an active session" }, status: :unauthorized
    end
  end

  def resource_params
    if params[:user]
      params.require(:user).permit(:email, :password)
    else
      params.permit(:email, :password)
    end
  end  
end
