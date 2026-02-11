class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @pagy, @users = pagy(:offset, User.public_details, limit: 40)
    render template: "admin/home/index"
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_admin_user_path(@user), notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to admin_users_path }
    end
  end

  private 
    def set_user
      @user = User.find_by(uid: params[:id])
      
      unless @user
        redirect_to admin_users_path, alert: "User not found."
      end
    end

    def user_params
      permitted = params.require(:user).permit(:fname, :lname, :email, :password, :role, :active, :remove_avatar, :avatar)

      if permitted[:password].blank?
        permitted.delete(:password)
        permitted.delete(:password_confirmation)
      end

      return permitted
    end
end
