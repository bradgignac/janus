require 'janus/comparer'
require 'janus/screenshot'

describe Janus::Comparer do
  let(:original) { Janus::Screenshot.new }
  let(:fresh) { Janus::Screenshot.new }

  it 'raises exception when screenshots do not match' do
    original.stub(:image) { 'original data' }
    fresh.stub(:image) { 'changes' }

    expect { Janus::Comparer.compare(original, fresh) }.to raise_error('Screenshots did not match!')
  end

  it 'does not raise exception when screenshots match' do
    original.stub(:image) { 'original data' }
    fresh.stub(:image) { 'original data' }

    expect { Janus::Comparer.compare(original, fresh) }.not_to raise_error
  end
end
