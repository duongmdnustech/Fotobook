class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]

  # GET /albums or /albums.json
  def index
    @albums.reset if @albums
    if (params[:type] == "following")
      @pagy, @albums = pagy(:countless, current_user.following_albums, limit: 6)
      respond_to do |format|
        format.html {render template: "home/index"}
        format.turbo_stream 
      end
      return
    else
      @pagy, @albums = pagy(:countless, Album.all.where(status: true).order(public_at: :desc), limit: 6)
      respond_to do |format|
        format.html {render template: "home/index"}
        format.turbo_stream 
      end
      return
    end
  end

  # GET /albums/1 or /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = current_user.albums.build
    @album.photos.build
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums or /albums.json
  def create
    @album = current_user.albums.build(album_params)
    @album.public_at = Time.current
    respond_to do |format|
      if @album.save
        format.html { redirect_to albums_profile_path, notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    safe_params = album_params
    if safe_params[:photo_ids].present? && safe_params[:photos_attributes].present?
      
      # Lấy danh sách các ID đang được tick chọn (chuyển về string để so sánh)
      # reject(&:blank?) để loại bỏ các giá trị rỗng "" do Rails sinh ra
      selected_ids = safe_params[:photo_ids].reject(&:blank?).map(&:to_s)

      # Lọc photos_attributes:
      # Giữ lại item nếu:
      # - Là ảnh mới upload (chưa có ID)
      # - HOẶC ID của nó nằm trong danh sách được tick chọn (selected_ids)
      safe_params[:photos_attributes].select! do |_key, attributes|
        attributes[:id].nil? || selected_ids.include?(attributes[:id].to_s)
      end
    end

    # 3. Update album với params đã được làm sạch
    respond_to do |format|
      if @album.update(safe_params)
        # Sửa đường dẫn redirect tùy theo ý bạn (ví dụ: albums_path hoặc @album)
        format.html { redirect_to edit_album_path, notice: "Album was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.destroy!

    respond_to do |format|
      format.html { redirect_to current_user.role == "user" ? albums_profile_path : admin_albums_path, notice: "Photo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.fetch(:album, {}).permit(
        :title, 
        :status, 
        :description, 
        photo_ids: [], 
        # SỬA: Đổi thành số nhiều (photos_) và liệt kê các cột bên trong
        photos_attributes: [:id, :title, :status, :image, :_destroy] 
      )
    end
end
