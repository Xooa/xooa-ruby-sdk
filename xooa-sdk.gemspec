
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "xooa/version"

Gem::Specification.new do |spec|
  spec.name          = "xooa-sdk"
  spec.version       = Xooa::VERSION
  spec.authors       = ["Kavi Sarna"]
  spec.email         = ["kavi.sarna@xooa.com"]
  spec.licenses      = ['Apache-2.0']
  spec.summary       = %q{Xooa Ruby SDK}
  spec.description   = %q{Xooa Ruby SDK for connecting to Xooa PaaS.}
  spec.homepage      = "https://github.com/Xooa/xooa-ruby-sdk"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
=begin
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
    spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
=end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'webmock', '~> 3.4', '>= 3.4.2'

  spec.add_development_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  spec.add_development_dependency 'typhoeus', '1.3.1'
  spec.add_development_dependency 'json', '~> 2.1'
  spec.add_development_dependency 'socket.io-client-simple', '~> 1.2', '>= 1.2.1'

end
