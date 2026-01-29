class HomeController < ApplicationController
  before_action :require_login

  def new
  end

  private
    def require_login
      unless user_signed_in?
        redirect_to "/auth/login"
        return
      end
      
      @user = User.user_with_public_details(current_user.uid)
    end
end