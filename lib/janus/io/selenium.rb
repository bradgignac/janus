require 'oily_png'
require 'selenium/webdriver'
require 'janus/screenshot'

module Janus
  module IO
    class Selenium
      def initialize(configuration)
        username = configuration.username
        access_key = configuration.access_key

        @driver = ::Selenium::WebDriver.for(:remote, {
          url: "http://#{username}:#{access_key}@ondemand.saucelabs.com/wd/hub",
          desired_capabilities: ::Selenium::WebDriver::Remote::Capabilities.chrome
        })
      end

      def read(test)
        @driver.get(test.url)

        png = @driver.screenshot_as(:png)
        image = ChunkyPNG::Image.from_blob(png)
        Janus::Screenshot.new(image)
      end
    end
  end
end
