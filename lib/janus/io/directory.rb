require 'oily_png'
require 'janus/screenshot'

module Janus
  module IO
    class Directory
      def initialize(configuration)
        @directory = configuration.directory
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

      def image_directory(test)
        File.join(@directory, "#{test.name}.janus")
      end

      def image_path(test)
        File.join(image_directory(test), 'screenshot.png')
      end
    end
  end
end
