require_relative 'apps/api'
$stdout.sync = true
run Api.freeze.app
