require 'oily_png'
require 'janus/rule'

describe Janus::DimensionsRule do
  subject { Janus::DimensionsRule.new(configuration) }

  let(:original) { double }
  let(:fresh) { double }
  let(:configuration) do
    configuration = double
    configuration.stub(:threshold) { 0.5 }
    configuration
  end

  describe '#execute' do
    it 'does not raise exception when dimensions are the same' do
      original.stub(:dimensions) { { width: 100, height: 100 } }
      fresh.stub(:dimensions) { { width: 100, height: 100 } }

      expect { subject.execute(original, fresh) }.not_to raise_error
    end

    it 'raises exception when dimensions are different' do
      original.stub(:dimensions) { { width: 100, height: 100 } }
      fresh.stub(:dimensions) { { width: 100, height: 200 } }

      expect { subject.execute(original, fresh) }.to raise_error
    end
  end
end

describe Janus::ThresholdRule do
  subject { Janus::ThresholdRule.new(configuration) }

  let(:original) { double }
  let(:fresh) { double }
  let(:configuration) do
    configuration = double
    configuration.stub(:threshold) { 0.5 }
    configuration
  end

  describe '#execute' do
    it 'does not raise exception when difference is below threshold' do
      original.stub(:pixels) { [ChunkyPNG::Color::WHITE, ChunkyPNG::Color::WHITE] }
      fresh.stub(:pixels) { [ChunkyPNG::Color::WHITE, ChunkyPNG::Color::WHITE] }

      expect { subject.execute(original, fresh) }.not_to raise_error
    end

    it 'does not raise exception when difference equals threshold' do
      original.stub(:pixels) { [ChunkyPNG::Color::WHITE, ChunkyPNG::Color::WHITE] }
      fresh.stub(:pixels) { [ChunkyPNG::Color::WHITE, ChunkyPNG::Color::BLACK] }

      expect { subject.execute(original, fresh) }.not_to raise_error
    end

    it 'raises exception when difference exceeds threshold' do
      original.stub(:pixels) { [ChunkyPNG::Color::WHITE, ChunkyPNG::Color::WHITE] }
      fresh.stub(:pixels) { [ChunkyPNG::Color::BLACK, ChunkyPNG::Color::BLACK] }

      expect { subject.execute(original, fresh) }.to raise_error
    end
  end
end
