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
        @configuration.tests.each do |test|
          record_screenshot(test)
        end
      end

      def record_screenshot(test)
        selenium = Janus::IO::Selenium.new(@configuration)
        screenshot = selenium.read(test)

        directory = Janus::IO::Directory.new(@configuration)
        directory.write(test, screenshot)
      end
    end
  end
end
