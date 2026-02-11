class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]

  # GET /photos or /photos.json
  def index
    safe_keyword = params[:query] ? ActiveRecord::Base.sanitize_sql_like(params[:query]) : ""
    puts safe_keyword
    #@photos.reset if @photos
    if params[:type] == "following" then
      @pagy, @photos = pagy(:countless, current_user.following_photos.where("title LIKE ? OR description LIKE ?", "%#{safe_keyword}%", "%#{safe_keyword}%"), limit: 12)
      respond_to do |format|
        format.html {render template: "home/index"}
        format.turbo_stream 
      end
      return
    elsif params[:type] == "discover" then
      @pagy, @photos = pagy(:countless,Photo.all.where("title LIKE ? OR description LIKE ?", "%#{safe_keyword}%", "%#{safe_keyword}%").order(public_at: :desc), limit: 12)
      respond_to do |format|
        format.html {render template: "home/index"}
        format.turbo_stream 
      end
      return
    else 
      @pagy, @photos = pagy(Photo.all, items: 12)
      respond_to do |format|
        format.html {render template: "home/index"}
        format.turbo_stream 
      end
      return
    end
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  def create
    @photo = current_user.photos.build(photo_params)
    
    respond_to do |format|
      if @photo.save
        flash[:notice] = "Photo was successfully created."
        format.html { redirect_to profile_path }
        format.json { render :show, status: :created, location: @photo }
      else
        flash.now[:alert] = "Create photo fail!"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        flash[:notice] = "Photo was successfully updated."
        format.html { redirect_to current_user.role == "user" ? profile_path : admin_photos_path, status: :see_other }
        format.json { render :show, status: :ok, location: @photo }
      else
        flash.now[:alert] = "Update photo fail!"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy!
    flash[:notice] = "Photo was successfully destroyed."
    respond_to do |format|
      format.html { redirect_to current_user.role == "user" ? photos_profile_path : admin_photos_path, status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:title, :description, :image, :status)
    end
end
