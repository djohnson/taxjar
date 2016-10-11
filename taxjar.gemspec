# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taxjar/version'

Gem::Specification.new do |spec|
  spec.name          = 'taxjar'
  spec.version       = Taxjar::VERSION
  spec.authors       = ['Darren Johnson, Ladislav Marsik']
  spec.email         = ['darrenbjohnson@gmail.com, laci.marsik@gmail.com']
  spec.summary       = %q{A Ruby wrapper for the Taxjar API}
  spec.description   = %q{A Ruby wrapper for the Taxjar API's sales tax and tax rate endpoints}
  spec.homepage      = 'http://github.com/djohnson/taxjar'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'vcr', '~> 2.9', '>= 2.9.0'
  spec.add_development_dependency 'webmock', '~> 1.20', '>= 1.20.0'

  spec.add_runtime_dependency 'faraday', ['>= 0.7', '< 0.10']
  spec.add_runtime_dependency 'faraday_middleware', ['>= 0.8', '< 0.10']
  spec.add_runtime_dependency 'multi_json', '>= 1.0.3', '~> 1.0'
end
