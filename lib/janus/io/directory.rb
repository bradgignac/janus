require 'oily_png'
require 'janus/screenshot'

module Janus
  module IO
    class Directory
      def initialize(directory, browser)
        @directory = directory
        @browser = browser
      end

      def read(test)
        path = image_path(test)
        image = ChunkyPNG::Image.from_file(path)
        Janus::Screenshot.new(image)
      end

      def write(test, screenshot)
        directory = image_directory(test)
        FileUtils.mkpath(directory) unless Dir.exists?(directory)

        path = image_path(test)
        screenshot.image.save(path)
      end

      private

      def image_path(test)
        segments = [@browser.platform, @browser.browser, @browser.version]
        file_name = segments.compact.join('-')

        File.join(image_directory(test), "#{file_name}.png")
      end

      def image_directory(test)
        File.join(@directory, "#{test.name}.janus")
      end
    end
  end
end
