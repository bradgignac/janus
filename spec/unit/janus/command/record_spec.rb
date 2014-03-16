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

    let(:browser) do
      browser = double
      browser
    end

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

    # TODO: Builder
    let(:selenium) do
      selenium = double
      selenium.stub(:read) { screenshot }
      selenium
    end

    before :each do
      Janus::IO::Directory.stub(:new) { directory }
      Janus::IO::Selenium.stub(:new) { selenium }
    end

    it 'reads screenshot from Selenium' do
      Janus::IO::Selenium.should_receive(:new).with('username', 'key', browser) { selenium }
      selenium.should_receive(:read).with(test) { screenshot }

      record.record_screenshot(browser, test)
    end

    it 'writes screenshot to Janus directory' do
      Janus::IO::Directory.should_receive(:new).with('base', browser) { directory}
      directory.should_receive(:write).with(test, screenshot)

      record.record_screenshot(browser, test)
    end
  end
end
