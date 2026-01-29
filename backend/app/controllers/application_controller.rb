class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Cho phép thêm key :fname, :lname khi Đăng ký (sign_up)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname])

    # Cho phép thêm key :fname, :lname khi Sửa tài khoản (account_update)
    devise_parameter_sanitizer.permit(:account_update, keys: [:fname, :lname])
  end
end
