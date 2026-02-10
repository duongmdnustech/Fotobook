class Admin::AlbumsController < ApplicationController
  def index
    render template: "admin/home/index"
  end
end
