class AddPriceToBookingPlayers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :booking_players, :price, currency: { present: false }
  end
end
