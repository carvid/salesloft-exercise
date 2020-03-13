Application.boot(:database) do |app|
  init do
    require 'rom'
    require 'rom-sql'
    register('database.config', ROM::Configuration.new(:sql, ENV['DATABASE_URL']))
  end
end
