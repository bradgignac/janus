require 'janus/command/validate'
require 'janus/configuration'

describe Janus::Command::Validate do
  let(:config) { Janus::Configuration.new({}) }
  let(:validate) { Janus::Command::Validate.new(config) }

  describe '#execute' do
    it 'validates screenshots for each configured test' do
      config.stub(:tests) { %w(one two) }

      validate.should_receive(:validate_screenshot).with('one')
      validate.should_receive(:validate_screenshot).with('two')

      validate.execute
    end
  end

  describe '#validate_screenshot' do
    let(:test) { double }
    let(:fresh) { double }
    let(:original) { double }

    # TODO: Builder
    let(:engine) do
      engine = double
      engine.stub(:execute)
      engine
    end

    # TODO: Builder
    let(:directory) do
      directory = double
      directory.stub(:read) { original }
      directory
    end

    # TODO: Builder
    let(:selenium) do
      selenium = double
      selenium.stub(:read) { fresh }
      selenium
    end

    before :each do
      Janus::IO::Directory.stub(:new) { directory }
      Janus::IO::Selenium.stub(:new) { selenium }
      Janus::Core::Engine.stub(:create) { engine }
    end

    it 'reads screenshot from Selenium' do
      Janus::IO::Selenium.should_receive(:new).with(config) { selenium }
      selenium.should_receive(:read).with(test) { fresh }

      validate.validate_screenshot(test)
    end

    it 'reads screenshot from directory' do
      Janus::IO::Directory.should_receive(:new).with(config) { directory }
      selenium.should_receive(:read).with(test) { original }

      validate.validate_screenshot(test)
    end

    it 'executes engine' do
      engine.should_receive(:execute).with(original, fresh)

      validate.validate_screenshot(test)
    end
  end
end
