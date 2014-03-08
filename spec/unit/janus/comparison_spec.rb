require 'janus/comparison'
require 'janus/comparison_result'
require 'janus/screenshot'

describe Janus::Comparison do
  let(:original) { Janus::Screenshot.new }
  let(:fresh) { Janus::Screenshot.new }

  it 'is successful when screenshots are the same size' do
    original.stub(:image) { 'original data' }
    original.stub(:dimensions) { { width: 100, height: 100 } }

    fresh.stub(:image) { 'original data' }
    fresh.stub(:dimensions) { { width: 100, height: 100 } }

    Janus::Comparison.compare(original, fresh).should be_successful
  end

  it 'is unsuccessful when screenshots are different sizes' do
    original.stub(:image) { 'original data' }
    original.stub(:dimensions) { { width: 100, height: 100 } }

    fresh.stub(:image) { 'original data' }
    fresh.stub(:dimensions) { { width: 100, height: 200 } }

    Janus::Comparison.compare(original, fresh).should_not be_successful
  end
end
