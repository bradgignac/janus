require 'janus/screenshot'
require 'selenium/webdriver'

module Janus
  class Recorder
    def initialize(username, access_key)
      @driver = Selenium::WebDriver.for(:remote, {
        url: "http://#{username}:#{access_key}@ondemand.saucelabs.com/wd/hub",
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
      })
    end

    def record(test)
      @driver.get(test.url)

      Screenshot.new(test: test, image: @driver.screenshot_as(:png))
    end
  end
end
