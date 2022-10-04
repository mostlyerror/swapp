module ClientsHelper
  def formatted_date(dt)
    dt.to_date.to_formatted_s(:date_of_birth)
  end

  def button_class(disabled)
    disabled ?
      "bg-gray-100 hover:none text-gray-500 text-center px-4 md:px-8 py-1 md:py-2 rounded-lg shadow cursor-not-allowed" :
      "bg-indigo-600 hover:bg-indigo-700 text-white text-center px-4 md:px-8 py-1 md:py-2 rounded-lg shadow"
  end

  def profile_photo_for(client)
    classes = "inline-block h-16 w-16 mr-2 rounded-full"
    src = client.profile_photo.attached? ? client.profile_photo : "default-profile-photo.png"
    if client.profile_photo.attached?
      src = client.profile_photo.variant(resize_to_fit: [100, 100])
      classes += " object-cover"
    else
      src = "default-profile-photo.png"
      classes += " object-contain"
    end
    image_tag(src, class: classes)
  end
end
