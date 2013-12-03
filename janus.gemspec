# coding: utf-8
require File.expand_path('../lib/janus/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name = 'janus'
  spec.version = Janus::VERSION
  spec.author = 'Brad Gignac'
  spec.email = 'bgignac@bradgignac.com'
  spec.description = 'Automated visual regression testing on Sauce Labs.'
  spec.summary = 'Automated visual regression testing on Sauce Labs.'
  spec.homepage = 'https://github.com/bradgignac/janus'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(%r{^spec/})
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('gli', '~> 2.8.1')
  spec.add_dependency('selenium-webdriver', '~> 2.37.0')

  spec.add_development_dependency('bundler', '~> 1.3.5')
  spec.add_development_dependency('guard', '~> 2.2.4')
  spec.add_development_dependency('guard-rspec', '~> 4.0.4')
  spec.add_development_dependency('rake', '~> 10.1.0')
  spec.add_development_dependency('rspec', '~> 2.14.1')
  spec.add_development_dependency('simplecov', '~> 0.8.2')
end
