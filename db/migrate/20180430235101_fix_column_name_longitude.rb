class FixColumnNameLongitude < ActiveRecord::Migration[5.1]
  def change
    rename_column :businesses, :langitude, :longitude
  end
end
