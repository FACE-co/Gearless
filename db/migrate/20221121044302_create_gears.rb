class CreateGears < ActiveRecord::Migration[7.0]
  def change
    create_table :gears do |t|
      t.string :gear_type
      t.integer :total_occupancy
      t.text :summary
      t.string :address
      t.float :price
      t.references :user, null: false, foreign_key: true
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
