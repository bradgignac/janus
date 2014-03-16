module Janus
  class Browser
    attr_reader :platform, :browser, :version

    def initialize(attributes = {})
      @platform = attributes['platform']
      @browser = attributes['browser']
      @version = attributes['version']
    end

    def to_s
      "#{platform}, #{browser} #{version}".strip
    end
  end
end
