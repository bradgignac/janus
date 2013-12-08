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
        screenshot = Janus::Screenshot.capture(test, username: @configuration.username, access_key: @configuration.access_key)
        screenshot.save('output')
      end
    end
  end
end
