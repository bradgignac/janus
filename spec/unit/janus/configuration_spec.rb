require 'fileutils'
require 'janus/configuration'
require 'janus/source/sauce'
require 'janus/storage/directory'
require 'janus/test'

describe Janus::Configuration do
  describe '::load' do
    it 'merges provided option hashes' do
      a = { a: '' }
      b = { b: '' }
      File.stub(:exists?) { true }
      IO.stub(:read) { YAML.dump({}) }

      Janus::Configuration.should_receive(:new).with({ a: '', b: '' })

      Janus::Configuration.load(a, b)
    end

    it 'includes options from YAML configuration when files exists' do
      config = { b: '', c: '' }
      IO.stub(:read) { YAML.dump(config) }
      File.stub(:exists?) { |f| f == 'Janusfile' }

      Janus::Configuration.should_receive(:new).with({ a: '', b: '', c: '' })

      Janus::Configuration.load({ a: '' }, config)
    end
  end

  describe '#source' do
    it 'instantiates driver with provided options' do
      Janus::Source::Sauce.should_receive(:new).with('some' => 'other', 'options' => 'too')

      configuration = Janus::Configuration.new({
        'source' => {
          'type' => 'sauce',
          'some' => 'other',
          'options' => 'too'
        }
      })
      configuration.source
    end
  end

  describe '#storage' do
    it 'instantiates driver with provided options' do
      Janus::Storage::Directory.should_receive(:new).with('some' => 'other', 'options' => 'too')

      configuration = Janus::Configuration.new({
        'storage' => {
          'type' => 'directory',
          'some' => 'other',
          'options' => 'too'
        }
      })
      configuration.storage
    end
  end

  describe '#threshold' do
    it 'returns threshold' do
      configuration = Janus::Configuration.new('threshold' => 0.1)
      configuration.threshold.should == 0.1
    end

    it 'defaults threshold to zero' do
      configuration = Janus::Configuration.new
      configuration.threshold.should == 0
    end
  end

  describe '#browsers' do
    it 'creates browser for each entry in configuration file' do
      browser_configuration = []
      browser_configuration << { 'platform' => 'a', 'name' => 'a', 'version' => 'a' }
      browser_configuration << { 'platform' => 'b', 'name' => 'b', 'version' => 'b' }

      configuration = Janus::Configuration.new({ 'browsers' => browser_configuration })

      configuration.browsers.each_with_index do |browser, i|
        browser.platform.should == browser_configuration[i]['platform']
        browser.name.should == browser_configuration[i]['name']
        browser.version.should == browser_configuration[i]['version']
      end
    end
  end

  describe '#tests' do
    it 'creates test for each entry in configuration file' do
      test_configuration = []
      test_configuration << { 'name' => 'a', 'url' => 'a' }
      test_configuration << { 'name' => 'b', 'url' => 'b' }

      configuration = Janus::Configuration.new({ 'tests' => test_configuration })

      configuration.tests.each_with_index do |test, i|
        test.name.should == test_configuration[i]['name']
        test.url.should == test_configuration[i]['url']
      end
    end
  end
end
