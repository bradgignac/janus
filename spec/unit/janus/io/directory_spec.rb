require 'janus/io/directory'

describe Janus::IO::Directory do
  # TODO: Builder
  let(:config) do
    config = double
    config.stub(:directory) { 'base' }
    config
  end

  # TODO: Builder
  let(:test) do
    test = double
    test.stub(:name) { 'my test' }
    test
  end

  let(:io) { Janus::IO::Directory.new(config) }

  describe '#read' do
    it 'loads screenshot from disk' do
      ChunkyPNG::Image.should_receive(:from_file).with('base/my test.janus/screenshot.png') { 'my image' }

      screenshot = io.read(test)
      screenshot.image.should == 'my image'
    end
  end

  describe '#write' do
    # TODO: Builder
    let(:image) do
      image = double
      image.stub(:save)
      image
    end

    let(:screenshot) { Janus::Screenshot.new(image) }

    before :each do
      FileUtils.stub(:mkpath)
    end

    it 'creates directory if it does not exist' do
      Dir.should_receive(:exists?) { false }
      FileUtils.should_receive(:mkpath).with('base/my test.janus')

      io.write(test, screenshot)
    end

    it 'does not create directory if it already exists' do
      Dir.should_receive(:exists?) { true }
      FileUtils.should_not_receive(:mkpath)

      io.write(test, screenshot)
    end

    it 'writes screenshot to disk' do
      image.should_receive(:save).with('base/my test.janus/screenshot.png')

      io.write(test, screenshot)
    end
  end
end
