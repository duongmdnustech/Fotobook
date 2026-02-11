class Admin::PhotosController < ApplicationController
  def index
    @pagy, @photos = pagy(:offset, Photo.all, limit: 40)
    render template: "admin/home/index"
  end
end
