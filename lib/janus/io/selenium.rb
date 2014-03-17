require 'oily_png'
require 'selenium/webdriver'
require 'janus/screenshot'

module Janus
  module IO
    class Selenium
      @@driver_pool = {}

      def initialize(username, access_key, browser)
        @username = username
        @access_key = access_key
        @browser = browser

        @driver = @@driver_pool[browser] || build_driver
      end

      def read(test)
        @driver.get(test.url)

        png = @driver.screenshot_as(:png)
        image = ChunkyPNG::Image.from_blob(png)
        Janus::Screenshot.new(image)
      end

      private

      def build_driver
        capabilities = ::Selenium::WebDriver::Remote::Capabilities.new(
          platform: @browser.platform,
          browser_name: @browser.name,
          version: @browser.version
        )

        driver = ::Selenium::WebDriver.for(:remote, {
          url: "http://#{@username}:#{@access_key}@ondemand.saucelabs.com/wd/hub",
          desired_capabilities: capabilities
        })
        @@driver_pool[@browser] = driver
      end
    end
  end
end
