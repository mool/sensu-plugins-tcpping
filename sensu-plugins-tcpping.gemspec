# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensu-plugins-tcpping/version'

Gem::Specification.new do |spec|
  spec.name          = 'sensu-plugins-tcpping'
  spec.version       = SensuPluginsTcpping::VERSION
  spec.authors       = ['Pablo Gutiérrez del Castillo']
  spec.email         = ['pablogutierrezdelc@gmail.com']

  spec.summary       = 'Sensu plugins for collect tcp ping metrics'
  spec.description   = 'This plugin allows you to ping a TCP port and collect metrics'
  spec.homepage      = 'https://github.com/mool/sensu-plugins-tcpping'
  spec.license       = 'MIT'

  spec.platform      = Gem::Platform::RUBY
  spec.files         = Dir.glob('{bin,lib}/**/*') + %w(LICENSE.txt README.md)
  spec.executables   = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sensu-plugin',  '1.2.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '0.32.1'
end
