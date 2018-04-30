class CreateBookingPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_players do |t|
      t.references :booking, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :player_pay_status, default: false

      t.timestamps
    end
  end
end
