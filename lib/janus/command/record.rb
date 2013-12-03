require 'janus/recorder'

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
        recorder = Janus::Recorder.new(@configuration.username, @configuration.access_key)
        screenshot = recorder.record(test)
        screenshot.save('output')
      end
    end
  end
end
