class ChangeStatusToString < ActiveRecord::Migration[7.0]
  def change
    change_column :rentals, :status, :string, default: 'pending'
  end
end
