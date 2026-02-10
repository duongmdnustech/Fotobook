class Admin::HomeController < ApplicationController
  def index
    @pagy, @users = pagy(:offset, User.public_details, limit: 40)
  end
end
