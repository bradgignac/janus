require 'fileutils'

module Janus
  class Screenshot
    attr_accessor :test, :image

    def initialize(parameters = {})
      @test = parameters[:test]
      @image = parameters[:image]
    end

    def save(path)
      directory = File.join(path, "#{test.name}.janus")

      FileUtils.mkpath(directory) unless Dir.exists?(directory)
      IO.write(File.join(directory, 'screenshot.png'), @image, mode: 'wb')
    end
  end
end
