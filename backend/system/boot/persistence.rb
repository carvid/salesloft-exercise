# frozen_string_literal: true

Application.boot(:persistence) do |app|
  start do
    use :database
    config = app['database.config']
    config.auto_registration(app.root + 'gateways/persistence')
    register('persistence.container', ROM.container(config))
  end
end
