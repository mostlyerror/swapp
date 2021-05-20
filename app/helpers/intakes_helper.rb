module IntakesHelper
  def to_htmlfor(key)
<<<<<<< HEAD
    key.gsub("/", "").parameterize.underscore
=======
    key.gsub("/", "")
    .gsub(/[^A-Za-z0-9\s]/i, '')
    .parameterize
    .underscore
  end

  def to_radio_htmlfor(key, choice)
    [key, choice].map {|i| i.to_s.parameterize.underscore }.join("_")
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
  end
end