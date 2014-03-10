require 'janus/core/rule'

module Janus
  module Core
    class Engine
      def self.create
        engine = Engine.new
        engine.add_rule(Janus::Core::DimensionsRule.new)
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
end
