class Admin::AlbumsController < ApplicationController
  def index
    @pagy, @albums = pagy(:offset, Album.all, limit: 40)
    render template: "admin/home/index"
  end
end
