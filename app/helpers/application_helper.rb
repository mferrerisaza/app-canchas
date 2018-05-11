module ApplicationHelper
  def profile_pic_or_generic(user)
    options = {
      gravity: :face, height: 300, width: 300, crop: 'fit',
      class: 'avatar dropdown-toggle avatar-md', id: 'navbar-wagon-menu',
      'data-toggle' => 'dropdown'
    }
    if user.photo.blank?
      cl_image_tag 'user.png', options
    else
      cl_image_tag user.photo, options
    end
  end

  def date_check(date)
    return 'Hoy' if date == Time.zone.today
    return 'Mañana' if date == Time.zone.today + 1
    return 'Pasado mañana' if date == Time.zone.today + 2
    l(date, format: '%a %d, %b')
  end

  def format_hour(value)
    return "#{value - 12}  AM" if value == 24
    return "#{value}  PM" if value == 12
    return "#{value - 12}  PM" if value > 12
    "#{value}  AM"
  end

  def extract_date(args = {})
    if args[:dates].present?
      dates = args[:dates].split('to').map { |date| Date.parse(date) }
      dates.size == 2 ? dates : dates.push(dates [0])
    else
      [Time.zone.today, Time.zone.today + 7]
    end
  end

  def generate_start_hour(field, args = {})
    start_hour = field.business.opening
    if args[:start_time].present? && args[:start_time].to_i >= start_hour
      start_hour = args[:start_time].to_i
    end
    start_hour
  end

  def generate_end_hour(field, args = {})
    end_hour = field.business.closing
    if args[:end_time].present? && args[:end_time].to_i <= end_hour
      end_hour = args[:end_time].to_i
    end
    end_hour
  end

  def generate_hours_range(field, args = {})
    start_hour = generate_start_hour(field, args)
    end_hour = generate_end_hour(field, args)
    (start_hour..end_hour)
  end

  def field_picture_or_generic(field)
    options =
      {
        height: 800, width: 800,
        crop: 'fit'
      }

    if field.photo.blank?
      cl_image_path('fieldplaceholder.jpg', options)
    else
      cl_image_path(field.photo, options)
    end
  end

  def business_logo_or_generic(business, add_class)
    options =
      {
        height: 300, width: 300, crop: :fill,
        class: add_class.to_s
      }
    if business.photo.blank?
      cl_image_tag('defaul-logo.png', options)
    else
      cl_image_tag(business.photo, options)
    end
  end

  def booking_avatar(player)
    if player['photo'].nil?
      cl_image_tag 'user.png', class: 'avatar avatar-lg'
    else
      cl_image_tag player.photo, class: 'avatar avatar-lg'
    end
  end
end
