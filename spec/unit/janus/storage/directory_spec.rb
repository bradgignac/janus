require 'janus/storage/directory'

describe Janus::Storage::Directory do
  let(:image) { double }
  let(:directory) { Janus::Storage::Directory.new('path' => 'destination') }

  let(:test) do
    test = double
    test.stub(:name) { 'test' }
    test
  end

  let(:browser) do
    browser = double
    browser.stub(:platform) { 'platform' }
    browser.stub(:name) { 'name' }
    browser.stub(:version)
    browser
  end

  let(:image) do
    image = double
    image.stub(:save)
    image
  end

  let(:screenshot) do
    screenshot = double
    screenshot.stub(:image) { image }
    screenshot
  end

  describe '#read' do
    it 'creates screenshot from file with version' do
      browser.stub(:version) { 'version' }

      ChunkyPNG::Image.should_receive(:from_file).with('destination/test.janus/platform-name-version.png') { image }

      screenshot = directory.read(test, browser)
      screenshot.image.should == image
    end

    it 'creates screenshot from file without version' do
      browser.stub(:version) { nil }

      ChunkyPNG::Image.should_receive(:from_file).with('destination/test.janus/platform-name.png') { image }

      screenshot = directory.read(test, browser)
      screenshot.image.should == image
    end
  end

  describe '#write' do
    before :each do
      FileUtils.stub(:mkpath)
    end

    it 'creates path if it does not exist' do
      FileUtils.should_receive(:mkpath).with('destination/test.janus')

      directory.write(test, browser, screenshot)
    end

    it 'writes screenshot with version to disk' do
      browser.stub(:version) { 'version' }
      image.should_receive(:save).with('destination/test.janus/platform-name-version.png')

      directory.write(test, browser, screenshot)
    end

    it 'writes screenshot without version to disk' do
      browser.stub(:version) { nil }
      image.should_receive(:save).with('destination/test.janus/platform-name.png')

      directory.write(test, browser, screenshot)
    end
  end
end
