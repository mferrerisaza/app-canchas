module ApplicationHelper
  def profile_pic_or_generic(user)
    if user.photo.blank?
      cl_image_tag "user.png",
      gravity: "center",
      height: 300,
      width: 300,
      crop: "fit",
      class: "avatar dropdown-toggle",
      id: "navbar-wagon-menu",
      "data-toggle" => "dropdown"
    else
      cl_image_tag user.photo,
        height: 300,
        width: 300,
        crop: :fill,
        gravity: :face,
        class: "avatar dropdown-toggle",
        id: "navbar-wagon-menu",
        "data-toggle" => "dropdown"
    end
  end

  def date_check(date)
    if date == Date.today
      return "Hoy"
    elsif date == Date.today + 1
      return "Mañana"
    elsif date == Date.today + 2
      return "Pasado mañana"
    else
      return l(date, format: "%a %d, %b")
    end
  end

  def format_hour(value)
    if value == 24
      return "#{value - 12}  AM"
    elsif value == 12
      return "#{value}  PM"
    elsif value > 12
      return "#{value - 12}  PM"
    else
      return "#{value} AM"
    end
  end

  def extract_date(args = {})
    if args[:dates].present?
      dates = args[:dates].split("to").map { |date| Date.parse(date) }
    else
      dates = [Date.today, Date.today + 7]
    end
  end

  def generate_hours_range(args = {}, field)
    if args[:start_time].present? && args[:start_time].to_i >= field.business.opening
      start_hour = args[:start_time].to_i
    else
      start_hour = field.business.opening
    end

    if args[:end_time].present? && args[:end_time].to_i <= field.business.closing
      end_hour = args[:end_time].to_i
    else
      end_hour = field.business.closing
    end

    time_range = (start_hour..end_hour)
  end
end
