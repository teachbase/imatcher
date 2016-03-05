require 'spec_helper'

describe Imatcher::Modes::Delta do
  let(:path_1) { image_path "a" }
  let(:path_2) { image_path "darker" }
  subject { Imatcher.compare(path_1, path_2, options) }

  let(:options) { { mode: :delta } }

  context "with darker image" do
    it "score around 0.075" do
      expect(subject.score).to be_within(0.005).of(0.075)
    end

    context "with custom threshold" do
      subject { Imatcher.compare(path_1, path_2, options).match? }

      context "below score" do
        let(:options) { { mode: :delta, threshold: 0.01 } }

        it { expect(subject).to be_falsey }
      end

      context "above score" do
        let(:options) { { mode: :delta, threshold: 0.1 } }

        it { expect(subject).to be_truthy }
      end
    end
  end

  context "with different images" do
    let(:path_2) { image_path "b" }

    it "score around 0.0046" do
      expect(subject.score).to be_within(0.0001).of(0.0046)
    end

    it "creates correct difference image" do
      expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path("delta_diff")))
    end

    context "with high tolerance" do
      let(:options) { { mode: :delta, tolerance: 0.1 } }

      it "score around 0.0038" do
        expect(subject.score).to be_within(0.0001).of(0.0038)
      end
    end
  end
end
