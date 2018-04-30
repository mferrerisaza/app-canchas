class AddBalanceToBookings < ActiveRecord::Migration[5.1]
  def change
    add_monetize :bookings, :balance, currency: { present: false }
  end
end
