class AddPriceToFields < ActiveRecord::Migration[5.1]
  def change
    add_monetize :fields, :price, currency: { present: false }
  end
end
