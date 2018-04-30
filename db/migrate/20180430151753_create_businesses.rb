class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.float :langitude
      t.float :latitude
      t.string :phone
      t.integer :rating
      t.string :nit
      t.string :bank_name
      t.string :bank_account_type
      t.string :bank_account_number
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
