class AddScheduleToBusiness < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :opening_hour, :time
    add_column :businesses, :closing_hour, :time
  end
end
