require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Ems
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.time_zone = "Hanoi"
  end
end
