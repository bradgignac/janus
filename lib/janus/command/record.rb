# coding: utf-8

require 'colorize'
require 'sauce/connect'
require 'janus/io/directory'
require 'janus/io/selenium'
require 'janus/screenshot'

module Janus
  module Command
    class Record
      def initialize(configuration)
        @configuration = configuration
      end

      def execute
        Sauce::Connect.connect!(quiet: true) if @configuration.tunnel?

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
        selenium = Janus::IO::Selenium.new(@configuration.username, @configuration.access_key, browser)
        screenshot = selenium.read(test)

        directory = Janus::IO::Directory.new(@configuration.directory, browser)
        directory.write(test, screenshot)

        print '✔ '.green
      rescue
        print '✖ '.red
      ensure
        puts test.name
      end
    end
  end
end
