# frozen_string_literal: true

require "spec_helper"

describe Imatcher::Modes::Grayscale do
  let(:path_1) { image_path "a" }
  let(:path_2) { image_path "darker" }
  subject { Imatcher.compare(path_1, path_2, **options) }

  let(:options) { {mode: :grayscale} }

  context "darker image" do
    it "score around 0.95" do
      expect(subject.score).to be_within(0.05).of(0.95)
    end
  end

  context "different images" do
    let(:path_2) { image_path "b" }

    it "score around 0.005" do
      expect(subject.score).to be_within(0.001).of(0.005)
    end

    it "creates correct difference image" do
      expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path("grayscale_diff")))
    end
  end

  context "with zero tolerance" do
    let(:options) { {mode: :grayscale, tolerance: 0} }

    context "darker image" do
      it "score equals to 1" do
        expect(subject.score).to eq 1.0
      end
    end

    context "different image" do
      let(:path_2) { image_path "b" }

      it "score around 0.016" do
        expect(subject.score).to be_within(0.001).of(0.016)
      end
    end

    context "equal image" do
      let(:path_2) { image_path "a" }

      it "score equals to 0" do
        expect(subject.score).to eq 0
      end
    end
  end

  context "with small tolerance" do
    let(:options) { {mode: :grayscale, tolerance: 8} }

    context "darker image" do
      it "score around 0.96" do
        expect(subject.score).to be_within(0.005).of(0.96)
      end
    end

    context "different image" do
      let(:path_2) { image_path "b" }

      it "score around 0.006" do
        expect(subject.score).to be_within(0.0005).of(0.006)
      end
    end
  end
end
