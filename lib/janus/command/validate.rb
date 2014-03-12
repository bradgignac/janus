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
        @configuration.tests.each do |test|
          validate_screenshot(test)
        end
      end

      def validate_screenshot(test)
        directory = Janus::IO::Directory.new(@configuration)
        original = directory.read(test)

        selenium = Janus::IO::Selenium.new(@configuration)
        fresh = selenium.read(test)

        engine = Janus::Core::Engine.create
        engine.execute(original, fresh)
      end
    end
  end
end
