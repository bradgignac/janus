require 'fileutils'
require 'janus/configuration'
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

  describe '#directory' do
    it 'returns directory' do
      configuration = Janus::Configuration.new('directory' => 'directory')
      configuration.directory.should == 'directory'
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

  describe '#username' do
    it 'returns username' do
      configuration = Janus::Configuration.new('username' => 'username')
      configuration.username.should == 'username'
    end
  end

  describe '#access_key' do
    it 'returns access key' do
      configuration = Janus::Configuration.new('access_key' => 'access_key')
      configuration.access_key.should == 'access_key'
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
