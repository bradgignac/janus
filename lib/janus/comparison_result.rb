module Janus
  class ComparisonResult
    def successful?
      raise NotImplementedError
    end
  end

  class SuccessfulComparison < ComparisonResult
    def successful?
      true
    end
  end

  class FailedComparison < ComparisonResult
    def successful?
      false
    end
  end
end
