source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in xooa-sdk.gemspec
gemspec

group :development, :test do
  gem 'rspec'
  gem 'rspec_junit_formatter' # Allows to inspect rspec output as junit output in Jenkins
  gem 'rubocop'
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'simplecov' # Ruby unit tests coverage framework
  gem 'simplecov-rcov' # Allows to inspect simplecov output in Jenkins
end
