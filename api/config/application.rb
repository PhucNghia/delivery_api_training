require_relative "boot"
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    config.active_job.queue_adapter = :sidekiq
  end
end
