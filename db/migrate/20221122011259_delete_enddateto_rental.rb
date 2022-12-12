class DeleteEnddatetoRental < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :timestamp
    remove_column :rentals, :end_date
    add_column :rentals, :end_date, :timestamp
  end
end
