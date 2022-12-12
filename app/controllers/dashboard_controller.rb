class DashboardController < ApplicationController
  before_action :set_user, only: [:show, :my_gear]

  def show
    @gears = Gear.all
    @rentals = Rental.where(user: @user)
  end

  def my_gear
    @rentals_by_me = Rental.where(user: @user)
    @rentals_by_me_pc = @rentals_by_me.select { |rental| (rental.status == "pending" || rental.status == "confirmed") }
    @rentals_hosted_by_me = Rental.select { |rental| rental.gear.user == current_user && rental.status }
    @rentals_completed_as_renter = Rental.where(user: @user, status: "completed")
    @rentals_completed_as_host = Rental.where(user: @user, status: "completed")
    @gears = Gear.where(user: @user)

    #1. Gears listed by me, rented by others
    rentals_v1 = Rental.select { |rental| (rental.gear.user_id == current_user.id && (rental.status == "pending" ||  rental.status == "confirmed")) || rental.user_id == current_user.id}
    @map_gears_all = Gear.where(id: rentals_v1.map(&:gear_id))

    @markers = @map_gears_all.geocoded.map do |gear|
      {
        lat: gear.latitude,
        lng: gear.longitude,
        info_window: render_to_string(partial: "info_window", locals: {gear: gear}),
        image_url: helpers.asset_url("green_marker.png")
      }
    end
  end

  private

  def set_user
    @user = current_user
  end
end
