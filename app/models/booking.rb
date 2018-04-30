class Booking < ApplicationRecord
  belongs_to :field
  has_many :booking_players
  has_many :users, through: :booking_players

  monetize :balance_cents

  validates :date, presence: true
  validates :number_players, inclusion: { in: Field::CAPACITY_RANGE }

  validate :check_number_of_players_if_splitable, on: [:create, :update]

  def check_number_of_players_if_splitable
    if self.splitable && self.number_players.nil?
      errors.messages[:booking] << "If splitable number of players needs to be greater than 0"
      return false
    else
      true
    end
  end
end
