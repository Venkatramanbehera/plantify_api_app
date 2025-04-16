class PasswordResetsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user
      otp = user.generate_reset_otp!
      render json: { message: "OTP sent to email", otp: otp }, status: :ok
    else
      render json: { error: "Email not found" }, status: :not_found
    end
  end

  def update
    user = User.find_by(email: params[:email])

    if user&.valid_reset_otp?(params[:otp])
      if user.update(password: params[:password])
        user.clear_reset_otp!
        render json: { message: "Password reset successful" }, status: :ok
      else
        render json: { message: user.errors.full_message }, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid or expired OTP" }, status: :unauthorized
    end
  end
end
