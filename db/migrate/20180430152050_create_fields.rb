class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields do |t|
      t.string :name
      t.references :business, foreign_key: true
      t.integer :field_capacity
      t.string :photo

      t.timestamps
    end
  end
end
