module IntakesHelper
  def to_htmlfor(key)
    key.gsub("/", "").parameterize.underscore
  end
end