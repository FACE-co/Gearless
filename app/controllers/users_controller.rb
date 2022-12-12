class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @gears = Gear.where(user: @user)
  end
end
