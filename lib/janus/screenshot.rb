require 'fileutils'
require 'selenium/webdriver'

module Janus
  class Screenshot
    attr_accessor :test, :image

    def self.capture(test, options = {})
      driver = Selenium::WebDriver.for(:remote, {
        url: "http://#{options[:username]}:#{options[:access_key]}@ondemand.saucelabs.com/wd/hub",
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
      })
      driver.get(test.url)

      Screenshot.new(test: test, image: driver.screenshot_as(:png))
    end

    def initialize(parameters = {})
      @test = parameters[:test]
      @image = parameters[:image]
    end

    def save(path)
      directory = File.join(path, "#{test.name}.janus")

      FileUtils.mkpath(directory) unless Dir.exists?(directory)
      IO.write(File.join(directory, 'screenshot.png'), @image, mode: 'wb')
    end
  end
end
