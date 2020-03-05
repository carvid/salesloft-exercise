# frozen_string_literal: true

require 'dry/system/container'

class Application < Dry::System::Container
  configure do |config|
    config.auto_register = %w[lib gateways]
  end

  load_paths!('lib', 'gateways', 'system')
end
