class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :verify_authenticity_token, only: :show, if: -> { request.format.js? }

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if params[:id] then
      self.set_user
      @photos = @user.public_photos
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def poll
    render "Hello fr"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.user_with_public_details(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end

    def require_login
      unless user_signed_in?
        redirect_to "/auth/login"
      end
      if !params[:id]
        params[:id] = current_user.uid
      end
      self.set_user
    end
end
