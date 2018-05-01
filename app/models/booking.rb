class Booking < ApplicationRecord
  belongs_to :field
  has_many :booking_players
  has_many :users, through: :booking_players

  monetize :balance_cents

  validates :date, presence: true
  validates :number_players, inclusion: { in: Field::CAPACITY_RANGE }, on: :update

  validate :check_number_of_players_if_splitable, on: [:create, :update]

  def check_number_of_players_if_splitable
    if self.splitable && self.number_players.nil?
      errors.messages[:booking] << "If splitable number of players needs to be greater than 0"
      return false
    else
      true
    end
  end

  def self.build_schedule(dates)
    dates.size == 2 ? date_range = (dates[0]...dates[1] + 1) : date_range = (dates[0]...dates[0] + 1)
    booking_hash = {}
    date_range.each do |date|
      field_hash = {}
      Field.all.each do |field|
        hour_hash = {}
        field.business.opening_hours.each do |hour|
          p "la hora es #{hour} el rango inicia #{date + hour.hour - 1.hour} termina: #{date + hour.hour}"
          hour_hash["#{hour}"]= self.where(date: date..date + 1).where(field: field).where(date: date + hour.hour..date + hour.hour + 1).size
        end
        field_hash[field.id.to_s] = hour_hash
      end
      booking_hash[date.to_s] = field_hash
    end
    return booking_hash
  end
end
