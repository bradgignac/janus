require 'janus/recorder'

describe Janus::Recorder do
  let(:png) { double }
  let(:driver) { double }
  let(:test) { { 'name' => 'name', 'url' => 'this is my url' } }
  let(:recorder) { Janus::Recorder.new('username', 'access_key') }

  it 'builds driver for specified user' do
    Selenium::WebDriver.should_receive(:for).with(:remote, {
      url: 'http://username:access_key@ondemand.saucelabs.com/wd/hub',
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
    }).and_return(driver)

    recorder
  end

  it 'takes screenshot of provided URL' do
    Selenium::WebDriver.stub(:for) { driver }
    driver.should_receive(:get).with('this is my url')
    driver.should_receive(:screenshot_as).with(:png).and_return(png)

    screenshot = recorder.record(test)
    screenshot.test.should be(test)
    screenshot.image.should be(png)
  end
end
