class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :field, foreign_key: true
      t.datetime :date
      t.string :status
      t.integer :number_players
      t.boolean :splitable, default: false

      t.timestamps
    end
  end
end
