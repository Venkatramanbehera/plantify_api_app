class ApplicationController < ActionController::API
    def authenticate_user!
        header = request.headers["Authorization"]
        token  = header.split(" ").last if header

        begin
            decode = JWT.decode(token, Rails.application.credentials.secret_key_base)
            @current_user = User.find(decode[0]["user_id"])
        rescue
            render json: { error: "Unauthorized" }, status: :unauthorized
        end
    end
end
