require 'spec_helper'

describe Imatcher::Modes::RGB do
  let(:path_1) { image_path "a" }
  let(:path_2) { image_path "darker" }
  subject { Imatcher.compare(path_1, path_2, options) }
  let(:options) { {} }

  context "with similar images" do
    it "score equals to 1" do
      expect(subject.score).to eq 1
    end
  end

  context "with different images" do
    let(:path_2) { image_path "b" }

    it "score around 0.97" do
      expect(subject.score).to be_within(0.005).of(0.97)
    end

    it "creates correct difference image" do
      expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path("rgb_diff")))
    end
  end
end
