class ChangeTimeStampToRentals < ActiveRecord::Migration[7.0]
  def change
    change_column :rentals, :start_date, :date
    change_column :rentals, :end_date, :date
  end
end
