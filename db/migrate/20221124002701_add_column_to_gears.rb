class AddColumnToGears < ActiveRecord::Migration[7.0]
  def change
    add_column :gears, :gear_name, :string
  end
end
