require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Swapp
  class Application < Rails::Application
    ENV["STAGING"] == "true" ?
      config.hosts << "swapp-staging-1.herokuapp.com" :
      config.hosts << "swapp-1.herokuapp.com"

    config.time_zone = "Mountain Time (US & Canada)"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.action_view.form_with_generates_remote_forms = true
  end
end
