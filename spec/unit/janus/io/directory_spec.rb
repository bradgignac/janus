require 'janus/io/directory'

describe Janus::IO::Directory do
  let(:directory) { 'base' }

  let(:browser) do
    browser = double
    browser.stub(:platform) { 'platform' }
    browser.stub(:name) { 'name' }
    browser.stub(:version) { nil }
    browser
  end

  # TODO: Builder
  let(:test) do
    test = double
    test.stub(:name) { 'my test' }
    test
  end

  let(:io) { Janus::IO::Directory.new(directory, browser) }

  describe '#read' do
    it 'loads screenshot from disk for browser with version' do
      browser.stub(:version) { 'version' }

      ChunkyPNG::Image.should_receive(:from_file).with('base/my test.janus/platform-name-version.png') { 'my image' }

      screenshot = io.read(test)
      screenshot.image.should == 'my image'
    end

    it 'loads screenshot from disk for browser without version' do
      ChunkyPNG::Image.should_receive(:from_file).with('base/my test.janus/platform-name.png') { 'my image' }

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

    it 'writes screenshot with version to disk' do
      browser.stub(:version) { 'version' }

      image.should_receive(:save).with('base/my test.janus/platform-name-version.png')

      io.write(test, screenshot)
    end

    it 'writes screenshot without version to disk' do
      image.should_receive(:save).with('base/my test.janus/platform-name.png')

      io.write(test, screenshot)
    end
  end
end
