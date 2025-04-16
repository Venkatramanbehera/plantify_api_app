Rails.application.routes.draw do
  get "health/check"
  post "/login",           to: "auth#login"
  post "/forgot_password", to: "password_resets#create"
  post "/reset_password",  to: "password_resets#update"

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
