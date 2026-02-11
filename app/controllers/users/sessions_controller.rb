# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :check_active, only: [:create]
  #after_action :authorize, [:create]

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
        self.resource = resource_class.new(sign_in_params)
        flash[:notice] = "Email or password is wrong!"
        render :new, notice: "Your account is being locked!", status: :unauthorized
      end
    end

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end

    def authorize
      if user_signed_in? 
        redirect_to new_user_session_path
      elsif current_user.role == "admin"
        redirect_to admin_root_path
      else 
        redirect_to root_path
      end
    end
end
