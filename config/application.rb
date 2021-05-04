require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Swapp
  class Application < Rails::Application
    config.hosts << '36fda4748b98.ngrok.io'

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
