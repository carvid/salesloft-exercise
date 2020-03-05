# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'

require 'bundler'
Bundler.setup(:default, ENV['APP_ENV'])

require 'dotenv'
Dotenv.load('.env', ".env.#{ENV['APP_ENV']}")

require_relative 'container'
require_relative 'import'

Application.finalize!
