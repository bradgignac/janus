module Janus
  class Screenshot
    attr_reader :image

    def initialize(image)
      @image = image
    end

    def dimensions
      { width: @image.width, height: @image.height }
    end

    def pixels
      @image.pixels
    end
  end
end
