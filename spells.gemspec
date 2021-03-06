# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spells/version'

Gem::Specification.new do |spec|
  spec.name          = 'spells'
  spec.version       = Spells::VERSION
  spec.authors       = ['Eric Cohen']
  spec.email         = ['eirc.eirc@gmail.com']
  spec.summary       = %q{Spells is a library for parsing the text on Magic: The Gathering cards}
  spec.homepage      = 'http://github.com/eirc/spells'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'addressable'

  spec.add_runtime_dependency 'treetop'
end
