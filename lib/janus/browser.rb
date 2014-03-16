module Janus
  class Browser
    attr_reader :platform, :name, :version

    def initialize(attributes = {})
      @platform = attributes['platform']
      @name = attributes['name']
      @version = attributes['version']
    end

    def to_s
      "#{platform}, #{name} #{version}".strip
    end
  end
end
