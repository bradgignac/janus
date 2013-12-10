require 'janus/configuration'
require 'janus/screenshot'
require 'janus/command/validate'

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
    let(:test) { Janus::Test.new('name' => 'my test') }
    let(:original) { Janus::Screenshot.new }
    let(:fresh) { Janus::Screenshot.new }

    before :each do
      Janus::Screenshot.stub(:load) { original }
      Janus::Screenshot.stub(:capture) { fresh }
    end

    it 'raises exception when screenshots do not match' do
      original.stub(:image) { 'original data' }
      fresh.stub(:image) { 'changes' }

      expect { validate.validate_screenshot(test) }.to raise_error('my test: Screenshots did not match!')
    end

    it 'does not raise exception when screenshots match' do
      original.stub(:image) { 'original data' }
      fresh.stub(:image) { 'original data' }

      expect { validate.validate_screenshot(test) }.not_to raise_error
    end
  end
end
