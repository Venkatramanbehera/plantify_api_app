class HealthController < ApplicationController
  # before_action :authenticate_user!
  def check
    render json: { status: "ok" }
  end
end
