require 'oily_png'
require 'janus/core/engine'
require 'janus/core/error'
require 'janus/screenshot'

describe Janus::Core::Engine do
  let(:config) { Janus::Configuration.new }
  let(:engine) { Janus::Core::Engine.create(config) }
  let(:square_base) { ChunkyPNG::Image::from_file('spec/support/square-base.png') }
  let(:square_big) { ChunkyPNG::Image::from_file('spec/support/square-big.png') }

  it 'succeeds for matching image' do
    original = Janus::Screenshot.new(square_base)
    fresh = Janus::Screenshot.new(square_base)

    expect { engine.execute(original, fresh) }.not_to raise_error
  end

  it 'fails for different sized image' do
    original = Janus::Screenshot.new(square_base)
    fresh = Janus::Screenshot.new(square_big)

    expect { engine.execute(original, fresh) }.to raise_error(Janus::Core::ComparisonError)
  end
end
