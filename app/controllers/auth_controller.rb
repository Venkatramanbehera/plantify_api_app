class AuthController < ApplicationController
    def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            payload = { user_id: user.id }
            token = JWT.encode(payload, Rails.application.credentials.secret_key_base)
            render json: { token: token }
        else
            render json: { token: token }, status: :unauthorized
        end
    end
end
