class ChangeDatatypeForLatLong < ActiveRecord::Migration[7.0]
  def up
    execute 'ALTER TABLE gears ALTER COLUMN latitude TYPE float USING (latitude::float)'
    execute 'ALTER TABLE gears ALTER COLUMN longitude TYPE float USING (longitude::float)'
  end
end
