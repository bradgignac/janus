require 'oily_png'
require 'janus/screenshot'

module Janus
  module Storage
    class Directory
      def initialize(options = {})
        @path = options['path']
      end

      def read(test, browser)
        path = File.join(directory_for(test), file_for(browser))
        image = ChunkyPNG::Image.from_file(path)
        Janus::Screenshot.new(image)
      end

      def write(test, browser, screenshot)
        path = directory_for(test)
        file = file_for(browser)

        FileUtils.mkpath(path)

        screenshot.image.save(File.join(path, file))
      end

      private

      def directory_for(test)
        File.join(@path, "#{test.name}.janus")
      end

      def file_for(browser)
        name = [browser.platform, browser.name, browser.version].compact.join('-')
        "#{name}.png"
      end
    end
  end
end
