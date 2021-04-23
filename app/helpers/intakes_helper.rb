module IntakesHelper
  def to_htmlfor(key)
    key.gsub("/", "")
    .gsub(/[^A-Za-z0-9\s]/i, '')
    .parameterize
    .underscore
  end
end