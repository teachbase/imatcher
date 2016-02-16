require 'spec_helper'

describe "Compare" do
  let(:path_1) { image_path "a" }
  let(:path_2) { image_path "darker" }
  subject { Imatcher.compare(path_1, path_2, options) }

  describe 'RGB' do
    let(:options) { {} }

    context "with similar images" do
      it "score equals to 1" do
        expect(subject.score).to eq 1
      end
    end

    context "with different images" do
      let(:path_2) { image_path "b" }

      it "score equals to 0.971224" do
        expect(subject.score).to eq 0.971224
      end

      it "creates correct difference image" do
        expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path "rgb_diff"))
      end
    end
  end

  describe 'Delta' do
    let(:options) { { mode: :delta } }

    context "with similar images" do
      it "score equals to 0.09413561679173654" do
        expect(subject.score).to eq 0.09413561679173654
      end

      context "with custom threshold" do
        subject { Imatcher.compare(path_1, path_2, options).match? }

        context "below score" do
          let(:options) { { mode: :delta, threshold: 0.01 } }

          it { expect(subject).to eq false }
        end

        context "above score" do
          let(:options) { { mode: :delta, threshold: 0.1 } }

          it { expect(subject).to eq true }
        end
      end
    end

    context "with different images" do
      let(:path_2) { image_path "b" }

      it "score equals to 0.019625652485167986" do
        expect(subject.score).to eq 0.019625652485167986
      end

      it "creates correct difference image" do
        expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path "delta_diff"))
      end
    end
  end

  describe 'Grayscale' do
    let(:options) { { mode: :grayscale } }

    context "with similar images" do
      it "score equals to 0.765716" do
        expect(subject.score).to eq 0.765716
      end
    end

    context "with different images" do
      let(:path_2) { image_path "b" }

      it "score equals to 0.009328" do
        expect(subject.score).to eq 0.009328
      end

      it "creates correct difference image" do
        expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path "grayscale_diff"))
      end
    end
  end
end
