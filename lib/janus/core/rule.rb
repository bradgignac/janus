require 'oily_png'
require 'janus/core/error'

module Janus
  module Core
    class Rule
      def execute(original, fresh)
      end
    end

    class DimensionsRule < Rule
      def execute(original, fresh)
        raise Janus::Core::ComparisonError unless original.dimensions == fresh.dimensions
      end
    end

    class ThresholdRule < Rule
      def initialize(threshold)
        @threshold = threshold
      end

      def execute(original, fresh)
        difference = calculate_total_difference(original, fresh)
        raise Janus::Core::ComparisonError unless difference <= @threshold
      end

      private

      def calculate_total_difference(original, fresh)
        pixels = original.pixels.zip(fresh.pixels)
        pixel_differences = pixels.map do |a, b|
          calculate_pixel_difference(a, b)
        end

        pixel_differences.reduce { |sum, value| sum + value } / pixels.length
      end

      def calculate_pixel_difference(original, fresh)
        r = (ChunkyPNG::Color.r(fresh) - ChunkyPNG::Color.r(original)) ** 2
        g = (ChunkyPNG::Color.g(fresh) - ChunkyPNG::Color.g(original)) ** 2
        b = (ChunkyPNG::Color.b(fresh) - ChunkyPNG::Color.b(original)) ** 2
        Math.sqrt(r + g + b) / Math.sqrt(ChunkyPNG::Color::MAX ** 2 * 3)
      end
    end
  end
end
