class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:create, :new, :index, :update, :edit, :destroy]

  def index
    @gears = Gear.all

    if params[:query].present?
      sql_query = <<~SQL
        gears.gear_name @@ :query
        OR gears.gear_type @@ :query
        OR gears.summary @@ :query
      SQL
      @gears = Gear.all.where(sql_query, query: "%#{params[:query]}%")
    else
      @gears = Gear.all
    end
  end

  def new
    @gear = Gear.new
  end

  def show
    @gear = Gear.find(params[:id])
    @rental = Rental.new
  end

  def create
    @gear = Gear.new(gear_params)
    @gear.user = @user
    if @gear.save
      redirect_to user_my_gear_path(@user), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @gear = Gear.find(params[:id])
    if @gear.update(gear_params)
      redirect_to user_my_gear_path(@user), notice: "Gear was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @gear = Gear.find(params[:id])
  end

  def destroy
    @gear = Gear.find(params[:id])
    @gear.destroy
    redirect_to user_my_gear_path(@user), notice: "Gear was successfully destroyed."
  end

  private

  def set_user
    @user = current_user
  end

  def gear_params
    params.require(:gear).permit(:gear_type, :gear_name, :total_occupancy, :summary, :address, :price, :latitude, :longitude, photos: [])
  end
end
