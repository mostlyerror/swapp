source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.1.2"

# pin Psych to this older version which remains compatible with Ruby 3.X+
# Eventually this needs to 'unfrozen' when the two are patched.
gem "psych", "< 4"
gem "aasm", "~> 5.1"
gem "active_interaction", "~> 4.0"
gem "acts_as_paranoid", "~> 0.7.3"
gem "amazing_print", "~> 1.3"
gem "auto_strip_attributes", "~> 2.6"
gem "aws-sdk-s3", "~> 1.114"
gem "bootsnap", ">= 1.4.2", require: false
gem "devise", "~> 4.7"
gem "fx", "~> 0.6.2"
gem "image_processing", "~> 1.12"
gem "jbuilder", "~> 2.7"
gem "pagy", "~> 5.10"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search", "~> 2.3"
gem "phonelib", "~> 0.6.48"
gem "puma", "~> 4.3"
gem "rails", "~> 6.0.3", ">= 6.0.3.6"
gem "ransack", github: "activerecord-hackery/ransack"
gem "react-rails", "~> 2.6"
gem "rollbar", "~> 3.3"
gem "sass-rails", ">= 6"
gem "sendgrid-actionmailer", "~> 3.2"
gem "smarter_csv", "~> 1.2"
gem "twilio-ruby"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "webpacker", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails", "~> 6.1"
  gem "ffaker", "~> 2.18"
  gem "timecop", "~> 0.9.4"
end

group :development do
  gem "listen", "~> 3.2"
  gem "rubocop", "~> 1.24"
  gem "rubocop-performance", "~> 1.13"
  gem "rubocop-rails", "~> 2.13"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end
