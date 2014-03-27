require 'janus/command/validate'
require 'janus/configuration'

describe Janus::Command::Validate do
  let(:config) { Janus::Configuration.new('username' => 'username', 'access_key' => 'key', 'directory' => 'base') }
  let(:validate) { Janus::Command::Validate.new(config) }

  before :each do
    validate.stub(:puts)
    validate.stub(:print)
  end

  describe '#execute' do
    it 'validates screenshots for each configured test' do
      config.stub(:browsers) { %w(red blue) }
      config.stub(:tests) { %w(one two) }

      validate.should_receive(:validate_screenshot).with('red', 'one')
      validate.should_receive(:validate_screenshot).with('red', 'two')
      validate.should_receive(:validate_screenshot).with('blue', 'one')
      validate.should_receive(:validate_screenshot).with('blue', 'two')

      validate.execute
    end
  end

  describe '#validate_screenshot' do
    let(:test) do
      test = double
      test.stub(:name)
      test
    end

    let(:fresh) { double }
    let(:original) { double }
    let(:browser) { double }

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
      config.stub(:source) { selenium }
      config.stub(:storage) { directory }

      Janus::Engine.stub(:create) { engine }
    end

    it 'reads screenshot from Selenium' do
      selenium.should_receive(:read).with(test, browser) { fresh }

      validate.validate_screenshot(browser, test)
    end

    it 'reads screenshot from directory' do
      directory.should_receive(:read).with(test, browser) { original }

      validate.validate_screenshot(browser, test)
    end

    it 'executes engine' do
      engine.should_receive(:execute).with(original, fresh)

      validate.validate_screenshot(browser, test)
    end
  end
end
