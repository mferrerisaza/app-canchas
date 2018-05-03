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

  def self.build_schedule(args = {})
    dates = ApplicationController.helpers.extract_date(args)
    date_range = (dates[0]...dates[0] + 1)
    booking_hash = {}
    date_range.each do |date|
      field_hash = {}
      Field.retrive_filtered_fields(args).each do |field|
        hour_hash = {}
        time_range = ApplicationController.helpers.generate_hours_range(args, field)
        time_range.each do |hour|
          hour_hash[hour.to_s] = self.where(date: date..date + 1).where(field: field).where(date: date + hour.hour..date + hour.hour + 1).size
        end
        field_hash[field.id.to_s] = hour_hash
      end
      booking_hash[date.to_s] = field_hash
    end
     booking_hash.each_key do |date_key|
      booking_hash[date_key].each_key do |field_key|
        booking_hash[date_key][field_key].keep_if { |k,v| v == 0 }
      end
        booking_hash[date_key].keep_if { |k,v| !v.blank?}
    end
  end
end
