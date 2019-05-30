require_relative 'boot'

require 'rails/all'



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DevopsOnDemand
  class Application < Rails::Application
    config.chat_email_interval_in_minutes = 45
    # Initialize configuration defaults for originally generated Rails version.
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
    config.load_defaults 5.1
    # Autoload presenters
    config.autoload_paths << Rails.root.join('app/presenters')
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
