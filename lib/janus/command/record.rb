require 'colorize'
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
        puts 'Recording screenshots...'
        puts ''

        @configuration.tests.each do |test|
          record_screenshot(test)
        end

        puts ''
      end

      def record_screenshot(test)
        selenium = Janus::IO::Selenium.new(@configuration)
        screenshot = selenium.read(test)

        directory = Janus::IO::Directory.new(@configuration)
        directory.write(test, screenshot)

        print '  ✔ '.green
        puts test.name
      end
    end
  end
end
