require 'janus/test'

describe Janus::Test do
  it 'sets name' do
    test = Janus::Test.new('name' => 'name')
    test.name.should == 'name'
  end

  it 'sets url' do
    test = Janus::Test.new('url' => 'url')
    test.url.should == 'url'
  end
end
