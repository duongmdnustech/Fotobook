# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :resource, only: [:edit]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super do |resource|
      UserMailer.with(user_id: resource.uid).new_user_email.deliver_now
    end
  end

  #GET /resource/edit
  def edit
    super
  end

  #PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:lname, :fname, :email, :password, :avatar])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:user, keys: [:lname, :fname, :avatar, :role])
  end

  def update_resource(resource, params)
    # Nếu user điền password mới HOẶC đổi email -> Cần current_password
    if params[:password].present? || params[:email] != resource.email
      super
    else
      # Nếu chỉ đổi tên, avatar -> Không cần current_password
      # Loại bỏ key current_password để tránh lỗi validation
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(resource)
    edit_profile_path
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
