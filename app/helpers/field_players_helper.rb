module FieldPlayersHelper
  def confirmed_players(players)
    a = players.select { |player| player.player_pay_status == true }
    a
  end
end
