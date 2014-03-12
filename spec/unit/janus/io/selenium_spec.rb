require 'janus/test'
require 'janus/io/selenium'

describe Janus::IO::Selenium do
  let(:image) { double }

  let(:driver) do
    driver = double
    driver.stub(:get)
    driver.stub(:screenshot_as)
    driver
  end

  let(:config) do
    config = double
    config.stub(:username) { 'username' }
    config.stub(:access_key) { 'key' }
    config
  end

  let(:test) do
    test = double
    test.stub(:url) { 'this is my url' }
    test
  end

  before :each do
    ChunkyPNG::Image::stub(:from_blob) { image }
    Selenium::WebDriver.stub(:for) { driver }
  end

  it 'builds Selenium with provided credentials' do
    Selenium::WebDriver.should_receive(:for).with(:remote, {
      url: "http://username:key@ondemand.saucelabs.com/wd/hub",
      desired_capabilities: ::Selenium::WebDriver::Remote::Capabilities.chrome
    })

    Janus::IO::Selenium.new(config)
  end

  it 'navigates to the provided URL' do
    driver.should_receive(:get).with('this is my url')

    io = Janus::IO::Selenium.new(config)
    io.read(test)
  end

  it 'creates image from PNG data' do
    blob = double
    driver.should_receive(:screenshot_as).with(:png) { blob }
    ChunkyPNG::Image.should_receive(:from_blob).with(blob) { image }

    io = Janus::IO::Selenium.new(config)

    screenshot = io.read(test)
    screenshot.image.should == image
  end
end
