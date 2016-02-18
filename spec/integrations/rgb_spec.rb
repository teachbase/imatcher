require 'spec_helper'

describe Imatcher::Modes::RGB do
  let(:path_1) { image_path "a" }
  let(:path_2) { image_path "darker" }
  subject { Imatcher.compare(path_1, path_2, options) }
  let(:options) { {} }

  context "with darker" do
    it "score equals to 1" do
      expect(subject.score).to eq 1
    end
  end

  context "with different images" do
    let(:path_2) { image_path "b" }

    it "score around 0.016" do
      expect(subject.score).to be_within(0.001).of(0.016)
    end

    it "creates correct difference image" do
      expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path("rgb_diff")))
    end
  end

  context "exclude area" do
    let(:options) { { exclude_area: [200, 150, 275, 200] } }
    let(:path_2) { image_path "a1" }
    it { expect(subject.difference_image).to eq Imatcher::Image.from_file(image_path "exclude") }
    it { expect(subject.score).to eq 0 }

    context "calculates score correctly" do
      let(:path_2) { image_path "darker" }

      it { expect(subject.score).to eq 1 }
    end
  end

  context "include area" do
    let(:options) { { include_area: [0, 0, 100, 100] } }
    let(:path_2) { image_path "a1" }
    it { expect(subject.difference_image).to eq Imatcher::Image.from_file(image_path "include") }
    it { expect(subject.score).to eq 0 }

    context "calculates score correctly" do
      let(:path_2) { image_path "darker" }
      it { expect(subject.score).to eq 1 }
    end
  end
end
