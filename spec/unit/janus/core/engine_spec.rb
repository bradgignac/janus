require 'janus/core/engine'
require 'janus/core/rule'

describe Janus::Core::Engine do
  describe '::create' do
    let(:config) { double }
    let(:engine) { double }

    before :each do
      Janus::Core::Engine.stub(:new) { engine }
    end

    it 'creates engine with rules' do
      engine.should_receive(:add_rule).with(an_instance_of(Janus::Core::DimensionsRule)).ordered
      engine.should_receive(:add_rule).with(an_instance_of(Janus::Core::ThresholdRule)).ordered

      Janus::Core::Engine.create(config)
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
