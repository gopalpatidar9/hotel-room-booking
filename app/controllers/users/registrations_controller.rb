class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  
  respond_to :json   

  private

  def sign_up_params
    params.permit(:name, :email, :password, :password_confirmation, :mobile_number, :address, :role)
  end

  def respond_with(resource, opts = {})
    if resource.persisted?
      render json: { message: 'Singed up successfully', user: resource }, status: :ok
    else
      render json: { errors: resource.errors.full_messages}, status: :unprocessable_entity 
    end
  end
end
