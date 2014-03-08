module Janus
  class Comparison
    def self.compare(original, fresh)
      if original.dimensions == fresh.dimensions
        Janus::SuccessfulComparison.new
      else
        Janus::FailedComparison.new
      end
    end
  end
end
