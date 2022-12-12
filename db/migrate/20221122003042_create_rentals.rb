class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.float :price
      t.float :total
      t.timestamp :start_date
      t.string :end_date
      t.string :timestamp
      t.boolean :status, default: false
      t.references :user, null: false, foreign_key: true
      t.references :gear, null: false, foreign_key: true

      t.timestamps
    end
  end
end
