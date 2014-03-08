require 'oily_png'
require 'janus/comparison'
require 'janus/comparison_result'
require 'janus/screenshot'
require 'janus/test'

describe Janus::Comparison do
  let(:square_base) { ChunkyPNG::Image::from_file('spec/support/square-base.png') }
  let(:square_big) { ChunkyPNG::Image::from_file('spec/support/square-big.png') }
  let(:test) { Janus::Test.new(name: 'integration', url: 'example.com') }

  it 'succeeds for matching image' do
    original = Janus::Screenshot.new(test: test, image: square_base)
    fresh = Janus::Screenshot.new(test: test, image: square_base)

    Janus::Comparison.compare(original, fresh).should be_successful
  end

  it 'fails for different sized image' do
    original = Janus::Screenshot.new(test: test, image: square_base)
    fresh = Janus::Screenshot.new(test: test, image: square_big)

    Janus::Comparison.compare(original, fresh).should_not be_successful
  end
end
