require 'janus/screenshot'
require 'janus/test'

describe Janus::Screenshot do
  let(:image) { 'image data' }
  let(:test) { Janus::Test.new({ 'name' => 'test-name' }) }
  let(:screenshot) { Janus::Screenshot.new(test: test, image: image) }

  describe '#save' do
    it 'creates test directory if it does not exist' do
      IO.stub(:write)
      Dir.stub(:exists?) { |p| false }

      FileUtils.should_receive(:mkpath).with('base/test-name.janus')

      screenshot.save('base')
    end

    it 'does not create test directory if it exists' do
      IO.stub(:write)
      Dir.stub(:exists?) { |p| p == 'base/test-name.janus' }

      FileUtils.should_not_receive(:mkpath).with('base/test-name.janus')

      screenshot.save('base')
    end

    it 'writes screenshot to disk' do
      FileUtils.stub(:mkpath)
      IO.should_receive(:write).with('base/test-name.janus/screenshot.png', image, mode: 'wb')

      screenshot.save('base')
    end
  end
end
