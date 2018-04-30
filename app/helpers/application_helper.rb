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
end
