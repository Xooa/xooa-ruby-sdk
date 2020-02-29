lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xooa/version'

Gem::Specification.new do |spec|
  spec.name          = 'xooa-sdk'
  spec.version       = Xooa::VERSION
  spec.authors       = ['Kavi Sarna']
  spec.email         = ['kavi.sarna@xooa.com']
  spec.licenses      = ['Apache-2.0']
  spec.summary       = %q{Xooa Ruby SDK}
  spec.description   = %q{Xooa Ruby SDK for connecting to Xooa Blockchain PaaS.}
  spec.homepage      = 'https://github.com/Xooa/xooa-ruby-sdk'

  spec.required_ruby_version = '>= 2.0'

  # Specify which files should be added to the gem when it is released.
  spec.files         = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'webmock', '~> 3.4', '>= 3.4.2'

  spec.add_development_dependency 'json', '~> 2.1'
  spec.add_development_dependency 'socket.io-client-simple', '~> 1.2', '>= 1.2.1'
  spec.add_development_dependency 'typhoeus', '1.3.1'
end
