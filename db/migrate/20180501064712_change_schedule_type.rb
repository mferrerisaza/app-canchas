class ChangeScheduleType < ActiveRecord::Migration[5.1]
  def change
    remove_column :businesses, :opening_hour
    remove_column :businesses, :closing_hour
  end
end
