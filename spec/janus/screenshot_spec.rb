require 'janus/screenshot'
require 'janus/test'

describe Janus::Screenshot do
  let(:image) { 'image data' }
  let(:test) { Janus::Test.new({ 'name' => 'test-name', 'url' => 'this is my url' }) }
  let(:screenshot) { Janus::Screenshot.new(test: test, image: image) }

  describe '::capture' do
    let(:png) { double }
    let(:driver) { double }

    before :each do
      Selenium::WebDriver.stub(:for) { driver }

      driver.stub(:get)
      driver.stub(:screenshot_as)
    end

    it 'builds driver for specified user' do
      Selenium::WebDriver.should_receive(:for).with(:remote, {
        url: 'http://username:access key@ondemand.saucelabs.com/wd/hub',
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
      }).and_return(driver)

      Janus::Screenshot.capture(test, username: 'username', access_key: 'access key')
    end

    it 'takes screenshot of provided URL' do
      driver.should_receive(:get).with('this is my url')
      driver.should_receive(:screenshot_as).with(:png).and_return(png)

      screenshot = Janus::Screenshot.capture(test)
      screenshot.test.should be(test)
      screenshot.image.should be(png)
    end
  end

  describe '::load' do
    it 'loads screenshot from disk' do
      IO.stub(:read) do |path, mode|
        'my image' if path == 'base/my test.janus/screenshot.png'
      end

      test = Janus::Test.new('name' => 'my test')
      screenshot = Janus::Screenshot.load(test, path: 'base')

      screenshot.test.should == test
      screenshot.image.should == 'my image'
    end
  end

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
