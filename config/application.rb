# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
require 'action_cable/engine'
# require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative './version'

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Store the schema as SQL
    config.active_record.schema_format = :sql

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Store analytics configuration
    config.analytics = config_for(:analytics)

    # Store Resque configuration
    config.resque = config_for(:resque)

    # Store security configurations
    config.security = config_for(:security)

    # Store file storage configurations
    config.file_storage = config_for(:file_storage)

    # Allowed application hosts
    config.hosts.push(*config.security[:allowed_hosts])

    # Use custom error pages
    config.exceptions_app = routes

    # Configure ActiveJob queue adapter
    config.active_job.queue_adapter = :resque

    routes.default_url_options[:host] = config.security[:default_host]
  end
end
