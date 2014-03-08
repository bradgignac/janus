require 'janus/configuration'
require 'janus/test'
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
    let(:test) { Janus::Test.new({ name: 'name', url: 'ur' }) }
    let(:screenshot) { double }
    let(:recorder) { double }

    it 'saves screenshot of test URL' do
      config.stub(:username) { 'username' }
      config.stub(:access_key) { 'access key' }

      Janus::Screenshot.should_receive(:capture).with(test, username: 'username', access_key: 'access key').and_return(screenshot)

      screenshot.should_receive(:save)

      record.record_screenshot(test)
    end
  end
end
