class Admin::UsersController < ApplicationController
  def index
    render template: "admin/home/index"
  end
end
