class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
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
end
