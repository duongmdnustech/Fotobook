# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :check_active, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super do |resource|
      resource.last_login_at = Time.current
      resource.save!
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
    def check_active
      @user = User.find_by(email: sign_in_params[:email])
      if !@user || !@user.active
        render :new, notice: "Your account is being locked!", status: :unauthorized
      end
    end

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end
end
