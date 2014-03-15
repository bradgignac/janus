require 'janus/screenshot'

describe Janus::Screenshot do
  let(:image) { double }

  describe '#dimensions' do
    it 'returns dimensions of image' do
      image.should_receive(:width) { 100 }
      image.should_receive(:height) { 200 }

      screenshot = Janus::Screenshot.new(image)
      screenshot.dimensions.should == { width: 100, height: 200 }
    end
  end

  describe '#pixels' do
    it 'returns pixels of image' do
      pixels = double

      image.should_receive(:pixels) { pixels }

      screenshot = Janus::Screenshot.new(image)
      screenshot.pixels.should == pixels
    end
  end
end
