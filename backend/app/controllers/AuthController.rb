class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def signup
    p signup_params
    user = User.new(signup_params)
    if user.save 
      render json: {message: "Sign up successfully"}, status: :created
    else
      render json: {errors: user.errors}, status: :bad_request
    end
  end

  def signup_params
    params.permit(:email, :fname, :lname, :password)
  end
end