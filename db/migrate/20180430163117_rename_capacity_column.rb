class RenameCapacityColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :fields, :field_capacity, :capacity
  end
end
