# coding: utf-8

require 'colorize'
require 'janus/engine'

module Janus
  module Command
    class Validate
      def initialize(configuration)
        @configuration = configuration
      end

      def execute
        puts 'Validating screenshots...'
        puts ''

        @configuration.browsers.each do |browser|
          validate_screenshots_for_browser(browser)
        end
      end

      def validate_screenshots_for_browser(browser)
        puts "#{browser}"
        puts ''

        @configuration.tests.each do |test|
          validate_screenshot(browser, test)
        end

        puts ''
      end

      def validate_screenshot(browser, test)
        fresh = @configuration.source.read(test, browser)
        original = @configuration.storage.read(test, browser)

        engine = Janus::Engine.create(@configuration)
        engine.execute(original, fresh)

        print '✔ '.green
      rescue
        print '✖ '.red
      ensure
        puts test.name
      end
    end
  end
end
