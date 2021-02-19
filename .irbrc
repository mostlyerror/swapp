if Rails.env == "development" || "test"
  include FactoryBot::Syntax::Methods
end