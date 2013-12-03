require 'janus/configuration'
require 'janus/recorder'
require 'janus/command/record'

describe Janus::Command::Record do
  let(:config) { Janus::Configuration.new({}) }
  let(:record) { Janus::Command::Record.new(config) }

  describe '#execute' do
    it 'records screenshot for each configured test' do
      config.stub(:tests) { ['one', 'two'] }

      record.should_receive(:record_screenshot).with('one')
      record.should_receive(:record_screenshot).with('two')

      record.execute
    end
  end

  describe '#record_screenshot' do
    let(:test) { { name: 'name', url: 'ur' } }
    let(:screenshot) { double }
    let(:recorder) { double }

    it 'saves screenshot of test URL' do
      Janus::Recorder.stub(:new) { recorder }

      screenshot.should_receive(:save)
      recorder.stub(:record) { |t| t == test ? screenshot : nil }

      record.record_screenshot(test)
    end
  end
end
