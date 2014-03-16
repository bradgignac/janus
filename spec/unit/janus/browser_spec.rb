require 'janus/browser'

describe Janus::Browser do
  it 'sets platform' do
    browser = Janus::Browser.new('platform' => 'platform')
    browser.platform.should == 'platform'
  end

  it 'sets browser' do
    browser = Janus::Browser.new('browser' => 'browser')
    browser.browser.should == 'browser'
  end

  it 'sets version' do
    browser = Janus::Browser.new('version' => '7')
    browser.version.should == '7'
  end


  describe '#to_s' do
    it 'converts to string for browser with version' do
      browser = Janus::Browser.new('platform' => 'platform', 'browser' => 'browser', 'version' => 0.7)
      browser.to_s.should == 'platform, browser 0.7'
    end

    it 'converts to string for browser without version' do
      browser = Janus::Browser.new('platform' => 'platform', 'browser' => 'browser')
      browser.to_s.should == 'platform, browser'
    end
  end
end
