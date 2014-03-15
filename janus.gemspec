# coding: utf-8
require File.expand_path('../lib/janus/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name = 'janus-cli'
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

  spec.add_dependency('colorize', '~> 0.6.0')
  spec.add_dependency('gli', '~> 2.8')
  spec.add_dependency('oily_png', '~> 1.1')
  spec.add_dependency('selenium-webdriver', '~> 2.37')

  spec.add_development_dependency('bundler', '~> 1.3')
  spec.add_development_dependency('guard', '~> 2.2')
  spec.add_development_dependency('guard-rspec', '~> 4.0')
  spec.add_development_dependency('rake', '~> 10.1')
  spec.add_development_dependency('rspec', '~> 2.14')
  spec.add_development_dependency('simplecov', '~> 0.8')
end
