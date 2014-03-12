require 'janus/core/error'

module Janus
  module Core
    class Rule
      def execute(original, fresh)
        raise NotImplementedError
      end
    end

    class DimensionsRule < Rule
      def execute(original, fresh)
        raise Janus::Core::ComparisonError unless original.dimensions == fresh.dimensions
      end
    end
  end
end
