class Booking < ApplicationRecord
  STATUS = %i[Pendiente Jugado Confirmada Cancelada]
  belongs_to :field
  has_many :booking_players, dependent: :destroy
  has_many :users, through: :booking_players

  monetize :balance_cents

  validates :date, :field_id, :number_players, presence: true
  validates :number_players,
            inclusion: { in: Field::CAPACITY_RANGE }, on: :update

  validate :check_number_of_players_if_splitable, on: %i[create update]

  def check_number_of_players_if_splitable
    error_text = 'If splitable number of players needs to be greater than 0'
    if splitable && number_players.nil?
      errors.messages[:booking] << error_text
      false
    else
      true
    end
  end

  def self.build_schedule(args = {})
    dates = ApplicationController.helpers.extract_date(args)
    date_range = (dates[0]...dates[0] + 1.day)
    booking_hash = {}
    date_range.each do |date|
      field_hash = {}
      Field.retrive_filtered_fields(args).each do |field|
        hour_hash = {}
        time_range =
          ApplicationController.helpers.generate_hours_range(field, args)
        time_range.each do |hour|
          hour_hash[hour.to_s] =
            where(date: date..date + 1)
            .where(field: field)
            .where(date: date + hour.hour..date + hour.hour + 1).size
        end
        field_hash[field.id.to_s] = hour_hash
      end
      booking_hash[date.to_s] = field_hash
    end
    booking_hash.each_key do |date_key|
      booking_hash[date_key].each_key do |field_key|
        if Date.parse(date_key) == Time.zone.today
          booking_hash[date_key][field_key].keep_if do |k, v|
            v.zero? && k.to_i > Time.zone.now.hour
          end
        else
          booking_hash[date_key][field_key].keep_if { |_k, v| v.zero? }
        end
      end
      booking_hash[date_key].keep_if { |_k, v| v.present? }
    end
  end
end
