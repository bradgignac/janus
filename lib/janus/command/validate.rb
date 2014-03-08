require 'janus/comparer'

module Janus
  module Command
    class Validate
      def initialize(configuration)
        @configuration = configuration
      end

      def execute
        @configuration.tests.each do |test|
          validate_screenshot(test)
        end
      end

      def validate_screenshot(test)
        original = Janus::Screenshot.load(test, path: 'output')
        fresh = Janus::Screenshot.capture(test, username: @configuration.username, access_key: @configuration.access_key)

        Janus::Comparer.compare(original, fresh)
      end
    end
  end
end
