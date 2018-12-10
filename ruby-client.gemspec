
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruby/client/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby-client"
  spec.version       = Ruby::Client::VERSION
  spec.authors       = ["Kavi Sarna"]
  spec.email         = ["kavi.sarna@xooa.com"]

  spec.summary       = "Xooa RubySDK"
  spec.homepage      = "https://www.xooa.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  #spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #  `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  spec.add_runtime_dependency 'typhoeus', '1.3.1'
  spec.add_runtime_dependency 'json', '~> 2.1'
  spec.add_runtime_dependency 'socket.io-client-simple', '~> 1.2', '>= 1.2.1'
  spec.add_runtime_dependency 'bundler', '~> 1.17', '>= 1.17.1'
  spec.add_runtime_dependency 'http-cookie', '~> 1.0', '>= 1.0.3'
  spec.add_runtime_dependency 'mime-types', '~> 3.2', '>= 3.2.2'
  spec.add_runtime_dependency 'netrc', '~> 0.11.0'

  #spec.add_development_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  #spec.add_development_dependency 'typhoeus'
  #spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.4', '>= 3.4.2'
  #spec.add_development_dependency 'autotest', '~> 4.4', '>= 4.4.6'
 # spec.add_development_dependency 'autotest-rails-pure', '~> 4.1', '>= 4.1.2'
  #spec.add_development_dependency 'autotest-growl', '~> 0.2', '>= 0.2.16'
  #spec.add_development_dependency 'autotest-fsevent', '~> 0.2.14'
  #spec.add_development_dependency 'bundler', '~> 1.17', '>= 1.17.1'
  #spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.1'
  spec.add_development_dependency 'rspec', '~> 3.8'
end
