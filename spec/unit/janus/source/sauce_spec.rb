require 'janus/source/sauce'

describe Janus::Source::Sauce do
  describe '#init' do
    it 'starts tunnel when tunnel option is true' do
      Sauce::Connect.should_receive(:connect!).with(quiet: true)

      Janus::Source::Sauce.new('tunnel' => true)
    end

    it 'does not start tunnel when tunnel option is false' do
      Sauce::Connect.should_not_receive(:connect!)

      Janus::Source::Sauce.new('tunnel' => false)
    end
  end

  describe '#capture' do
    let(:test) do
      test = double
      test.stub(:url) { 'this is my url' }
      test
    end

    let(:driver) do
      driver = double
      driver.stub(:get)
      driver.stub(:capture_screenshot)
      driver
    end

    let(:browser) do
      browser = double
      browser.stub(:platform) { 'platform' }
      browser.stub(:name) { 'name' }
      browser.stub(:version) { 'version' }
      browser
    end

    let(:sauce) { Janus::Source::Sauce.new }

    before :each do
      ENV.stub(:[]) { |key| key }
      Selenium::WebDriver.stub(:for) { driver }
    end

    it 'creates new driver for browser' do
      url = 'http://SAUCE_USERNAME:SAUCE_ACCESS_KEY@ondemand.saucelabs.com/wd/hub'
      capabilities = Selenium::WebDriver::Remote::Capabilities.new({
        platform: 'platform',
        browser_name: 'name',
        version: 'version'
      })
      Selenium::WebDriver.should_receive(:for).with(:remote, url: url, desired_capabilities: capabilities)

      sauce.capture(test, browser)
    end

    it 're-uses existing driver when browser is used again' do
      sauce.capture(test, browser)

      Selenium::WebDriver.should_not_receive(:for)

      sauce.capture(test, browser)
    end

    it 'navigates to provided URL' do
      driver.should_receive(:get).with('this is my url')

      sauce.capture(test, browser)
    end

    it 'captures screenshot' do
      capture = double
      driver.should_receive(:capture_screenshot) { capture }

      screenshot = sauce.capture(test, browser)
      screenshot.should == capture
    end
  end
end

describe Selenium::WebDriver::Driver do
  describe '#capture_screenshot' do
    let(:bridge) do
      bridge = double
      bridge.stub(:driver_extensions) { [] }
      bridge
    end

    it 'creates image from raw PNG' do
      blob = double
      image = double
      ChunkyPNG::Image.should_receive(:from_blob).with(blob) { image }

      driver = Selenium::WebDriver::Driver.new(bridge)
      driver.should_receive(:screenshot_as).with(:png) { blob }

      screenshot = driver.capture_screenshot
      screenshot.image.should == image
    end
  end
end
