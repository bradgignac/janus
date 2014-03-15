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
end
