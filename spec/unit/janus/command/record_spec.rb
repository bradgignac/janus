require 'sauce/connect'
require 'janus/command/record'
require 'janus/configuration'

describe Janus::Command::Record do
  let(:config) { Janus::Configuration.new('username' => 'username', 'access_key' => 'key', 'directory' => 'base') }
  let(:record) { Janus::Command::Record.new(config) }

  before :each do
    record.stub(:puts)
    record.stub(:print)
  end

  describe '#execute' do
    it 'records screenshot for each configured test and browser combination' do
      config.stub(:browsers) { ['red', 'blue'] }
      config.stub(:tests) { ['one', 'two'] }

      record.should_receive(:record_screenshot).with('red', 'one')
      record.should_receive(:record_screenshot).with('red', 'two')
      record.should_receive(:record_screenshot).with('blue', 'one')
      record.should_receive(:record_screenshot).with('blue', 'two')

      record.execute
    end
  end

  describe '#record_screenshot' do
    let(:screenshot) { double }
    let(:browser) { double }

    let(:test) do
      test = double
      test.stub(:name)
      test
    end

    # TODO: Builder
    let(:directory) do
      directory = double
      directory.stub(:write)
      directory
    end

    # TODO: Builder and rename to sauce.
    let(:selenium) do
      selenium = double
      selenium.stub(:read) { screenshot }
      selenium
    end

    before :each do
      config.stub(:source) { selenium }
      config.stub(:storage) { directory }
    end

    it 'reads screenshot from Selenium' do
      selenium.should_receive(:read).with(test, browser) { screenshot }

      record.record_screenshot(browser, test)
    end

    it 'writes screenshot to Janus directory' do
      directory.should_receive(:write).with(test, browser, screenshot)

      record.record_screenshot(browser, test)
    end
  end
end
