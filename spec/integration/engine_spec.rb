require 'oily_png'
require 'janus/configuration'
require 'janus/engine'
require 'janus/screenshot'

describe 'Engine Integration Test' do
  let(:config) { Janus::Configuration.new('threshold' => 0.2) }
  let(:engine) { Janus::Engine.create(config) }
  let(:square_base) { ChunkyPNG::Image::from_file('spec/support/square-base.png') }
  let(:square_big) { ChunkyPNG::Image::from_file('spec/support/square-big.png') }
  let(:square_ten) { ChunkyPNG::Image::from_file('spec/support/square-ten.png') }
  let(:square_twenty) { ChunkyPNG::Image::from_file('spec/support/square-twenty.png') }
  let(:square_thirty) { ChunkyPNG::Image::from_file('spec/support/square-thirty.png') }

  it 'succeeds for matching image' do
    original = Janus::Screenshot.new(square_base)
    fresh = Janus::Screenshot.new(square_base)

    expect { engine.execute(original, fresh) }.not_to raise_error
  end

  it 'succeeds for image below threshold' do
    original = Janus::Screenshot.new(square_base)
    fresh = Janus::Screenshot.new(square_ten)

    expect { engine.execute(original, fresh) }.not_to raise_error
  end

  it 'succeeds for image matching threshold' do
    original = Janus::Screenshot.new(square_base)
    fresh = Janus::Screenshot.new(square_twenty)

    expect { engine.execute(original, fresh) }.not_to raise_error
  end

  it 'fails for image exceeding threshold' do
    original = Janus::Screenshot.new(square_base)
    fresh = Janus::Screenshot.new(square_thirty)

    expect { engine.execute(original, fresh) }.to raise_error
  end

  it 'fails for different sized image' do
    original = Janus::Screenshot.new(square_base)
    fresh = Janus::Screenshot.new(square_big)

    expect { engine.execute(original, fresh) }.to raise_error
  end
end
