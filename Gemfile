
source "https://rubygems.org"

git_source(:github) {|xooa| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in xooa-sdk.gemspec
gemspec


group :development, :test do
    gem 'rubocop'
    gem 'rubocop-checkstyle_formatter', require: false
    gem "rspec"
    gem 'simplecov' # Ruby unit tests coverage framework
    gem 'simplecov-rcov' # Allows to inspect simplecov output in Jenkins
    gem 'rspec_junit_formatter' # Allows to inspect rspec output as junit output in Jenkins
end