# coding: utf-8

require 'colorize'

module Janus
  module Command
    class Record
      def initialize(configuration)
        @configuration = configuration
      end

      def execute
        puts 'Recording screenshots...'
        puts ''

        @configuration.browsers.each do |browser|
          record_screenshots_for_browser(browser)
        end
      end

      def record_screenshots_for_browser(browser)
        puts "#{browser}"
        puts ''

        @configuration.tests.each do |test|
          record_screenshot(browser, test)
        end

        puts ''
      end

      def record_screenshot(browser, test)
        screenshot = @configuration.source.read(test, browser)
        @configuration.storage.write(test, browser, screenshot)

        print '✔ '.green
      rescue
        print '✖ '.red
      ensure
        puts test.name
      end
    end
  end
end
