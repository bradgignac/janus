# coding: utf-8

require 'colorize'
require 'janus/core/engine'
require 'janus/io/directory'
require 'janus/io/selenium'

module Janus
  module Command
    class Validate
      def initialize(configuration)
        @configuration = configuration
      end

      def execute
        puts 'Validating screenshots...'
        puts ''

        @configuration.tests.each do |test|
          validate_screenshot(test)
        end

        puts ''
      end

      def validate_screenshot(test)
        selenium = Janus::IO::Selenium.new(@configuration.username, @configuration.access_key)
        fresh = selenium.read(test)

        directory = Janus::IO::Directory.new(@configuration.directory)
        original = directory.read(test)

        engine = Janus::Core::Engine.create(@configuration)
        engine.execute(original, fresh)

        print '  ✔ '.green
      rescue
        print '  ✖ '.red
      ensure
        puts test.name
      end
    end
  end
end
