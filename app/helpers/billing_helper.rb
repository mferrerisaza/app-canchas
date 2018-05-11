module BillingHelper
  def total_price(price)
    price / 100
  end

  def price_per_person(price, number_players)
    price / number_players / 100
  end

  def humanize_price(price)
    humanized_money(price)
  end

  def free_slots(number_players, total_players)
    number_players - total_players
  end

  def paid_players(splitable, n_players, paid_players)
    if splitable
      "#{paid_players} de #{n_players} han pagado"
    else
      'Pagado a la fecha'
    end
  end

  def count_paid_players(players)
    a = players.select { |player| player.player_pay_status == true }.count
    a
  end

  def total_paid(n_paid_players, price_per_player)
    n_paid_players * price_per_player
  end

  def pending_to_pay(total_paid, total_price)
    total_price - total_paid
  end
end
