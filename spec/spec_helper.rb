require "bundler/setup"
#require "./xooa-sdk/lib/xooa/ruby/sdk"
require "rspec"

require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatters = [
    SimpleCov::Formatter::RcovFormatter, # Output for Jenkins
    SimpleCov::Formatter::HTMLFormatter # Output for development environment
]
SimpleCov.start 

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expose_dsl_globally = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
