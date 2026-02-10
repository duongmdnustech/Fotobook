class Admin::HomesController < ApplicationController
  before_action :set_admin_home, only: %i[ show edit update destroy ]

  # GET /admin/homes or /admin/homes.json
  def index
    @admin_homes = Admin::Home.all
  end

  # GET /admin/homes/1 or /admin/homes/1.json
  def show
  end

  # GET /admin/homes/new
  def new
    @admin_home = Admin::Home.new
  end

  # GET /admin/homes/1/edit
  def edit
  end

  # POST /admin/homes or /admin/homes.json
  def create
    @admin_home = Admin::Home.new(admin_home_params)

    respond_to do |format|
      if @admin_home.save
        format.html { redirect_to @admin_home, notice: "Home was successfully created." }
        format.json { render :show, status: :created, location: @admin_home }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/homes/1 or /admin/homes/1.json
  def update
    respond_to do |format|
      if @admin_home.update(admin_home_params)
        format.html { redirect_to @admin_home, notice: "Home was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @admin_home }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/homes/1 or /admin/homes/1.json
  def destroy
    @admin_home.destroy!

    respond_to do |format|
      format.html { redirect_to admin_homes_path, notice: "Home was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_home
      @admin_home = Admin::Home.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def admin_home_params
      params.fetch(:admin_home, {})
    end
end
