require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Laura
  class Application < Rails::Application

    config.active_record.raise_in_transactional_callbacks = true

    config.encoding = "utf-8"
    config.active_record.schema_format = :sql
  end
end
