module IntakesHelper
  def to_htmlfor(key)
    key.gsub("/", "")
    .gsub(/[^A-Za-z0-9\s]/i, '')
    .parameterize
    .underscore
  end

  def to_radio_htmlfor(key, choice)
    [key, choice].map {|i| i.to_s.parameterize.underscore }.join("_")
  end
end