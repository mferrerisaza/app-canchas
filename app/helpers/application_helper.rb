module ApplicationHelper
  def profile_pic_or_generic(user)
    options = {
      gravity: :face, height: 300, width: 300, crop: 'fit',
      class: 'avatar dropdown-toggle', id: 'navbar-wagon-menu',
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

  def generate_hours_range(field, args = {})
    start_hour = field.business.opening
    end_hour = field.business.closing

    if args[:start_time].present? && args[:start_time].to_i >= start_hour
      start_hour = args[:start_time].to_i
    end

    if args[:end_time].present? && args[:end_time].to_i <= end_hour
      end_hour = args[:end_time].to_i
    end

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

  def business_logo_or_generic(business)
    options =
      {
        height: 300, width: 300, crop: :fill, gravity: :face,
        class: 'card-top-business-logo'
      }
    if business.photo.blank?
      cl_image_tag('defaul-logo.png', options)
    else
      cl_image_tag(business.photo, options)
    end
  end
end
