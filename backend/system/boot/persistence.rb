# frozen_string_literal: true

Application.boot(:persistence) do |app|
  init do
    require 'rom'
    require 'rom-sql'

    register('persistence.config', ROM::Configuration.new(:sql, ENV['DATABASE_URL']))
  end

  start do
    config = app['persistence.config']
    config.auto_registration(app.root + 'gateways/persistence')
    register('persistence.container', ROM.container(config))
  end
end
