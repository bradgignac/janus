require 'janus/core/engine'
require 'janus/core/rule'

describe Janus::Core::Engine do
  describe '::create' do
    let(:engine) { double }

    it 'creates engine with DimensionsRule' do
      Janus::Core::Engine.stub(:new) { engine }

      engine.should_receive(:add_rule).with(an_instance_of(Janus::Core::DimensionsRule))

      Janus::Core::Engine.create
    end
  end

  describe '#execute' do
    let(:rule) { double }
    let(:original) { double }
    let(:fresh) { double }

    it 'executes each rule' do
      rule.should_receive(:execute).exactly(3).times

      subject.add_rule(rule)
      subject.add_rule(rule)
      subject.add_rule(rule)

      subject.execute(original, fresh)
    end
  end
end
