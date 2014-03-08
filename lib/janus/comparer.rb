module Janus
  class Comparer
    def self.compare(original, fresh)
      raise 'Screenshots did not match!' unless original.image == fresh.image
    end
  end
end
