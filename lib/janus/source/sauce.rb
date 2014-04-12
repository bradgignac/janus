require 'oily_png'
require 'sauce/connect'
require 'selenium/webdriver'
require 'janus/screenshot'

module Janus
  module Source
    class Sauce
      @@driver_pool = {}

      def initialize(options = {})
        ::Sauce::Connect.connect!(quiet: true) if options['tunnel']
      end

      def capture(test, browser)
        driver = build_driver(browser)
        driver.get(test.url)
        driver.capture_screenshot
      end

      private

      def build_driver(browser)
        unless @@driver_pool.key?(browser)
          url = "http://#{username}:#{access_key}@ondemand.saucelabs.com/wd/hub"
          capabilities = Selenium::WebDriver::Remote::Capabilities.new({
            platform: browser.platform,
            browser_name: browser.name,
            version: browser.version
          })
          @@driver_pool[browser] = Selenium::WebDriver.for(:remote, url: url, desired_capabilities: capabilities)
        end

        @@driver_pool[browser]
      end

      def username
        ENV['SAUCE_USERNAME']
      end

      def access_key
        ENV['SAUCE_ACCESS_KEY']
      end
    end
  end
end

class Selenium::WebDriver::Driver
  def capture_screenshot
    png = screenshot_as(:png)
    image = ChunkyPNG::Image.from_blob(png)
    Janus::Screenshot.new(image)
  end
end
