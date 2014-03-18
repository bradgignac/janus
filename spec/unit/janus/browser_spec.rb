require 'janus/browser'

describe Janus::Browser do
  it 'sets platform' do
    browser = Janus::Browser.new('platform' => 'platform')
    browser.platform.should == 'platform'
  end

  it 'sets name' do
    browser = Janus::Browser.new('name' => 'name')
    browser.name.should == 'name'
  end

  it 'sets version' do
    browser = Janus::Browser.new('version' => '7')
    browser.version.should == '7'
  end

  describe '#eql' do
    let(:platform) { 'platform' }
    let(:name) { 'name' }
    let(:version) { 'version' }
    let(:a) { Janus::Browser.new('platform' => platform, 'name' => name, 'version' => version) }

    it 'is false when platform is different' do
      b = Janus::Browser.new('platform' => 'different', 'name' => name, 'version' => version)
      b.should_not eql(a)
    end

    it 'is false when name is different' do
      b = Janus::Browser.new('platform' => platform, 'name' => 'different', 'version' => version)
      b.should_not eql(a)
    end

    it 'is false when version is different' do
      b = Janus::Browser.new('platform' => platform, 'name' => name, 'version' => 'different')
      b.should_not eql(a)
    end

    it 'is true when browser, name, and version are the same' do
      b = Janus::Browser.new('platform' => platform, 'name' => name, 'version' => version)
      b.should eql(a)
    end
  end

  describe '#to_s' do
    it 'converts to string for browser with version' do
      browser = Janus::Browser.new('platform' => 'platform', 'name' => 'name', 'version' => 0.7)
      browser.to_s.should == 'platform, name 0.7'
    end

    it 'converts to string for browser without version' do
      browser = Janus::Browser.new('platform' => 'platform', 'name' => 'name')
      browser.to_s.should == 'platform, name'
    end
  end
end
