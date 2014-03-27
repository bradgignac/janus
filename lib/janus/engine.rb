require 'janus/rule'

module Janus
  class Engine
    def self.create(configuration)
      engine = Engine.new
      engine.add_rule(Janus::DimensionsRule.new(configuration))
      engine.add_rule(Janus::ThresholdRule.new(configuration))
      engine
    end

    def initialize
      @rules = []
    end

    def add_rule(rule)
      @rules << rule
    end

    def execute(original, fresh)
      @rules.each { |r| r.execute(original, fresh) }
    end
  end
end
