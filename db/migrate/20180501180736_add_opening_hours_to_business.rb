class AddOpeningHoursToBusiness < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :opening, :integer, default: 8
    add_column :businesses, :closing, :integer, default: 22
  end
end
