require 'spec_helper'

describe "Compare" do
  let(:path_1) { image_path "a" }
  let(:path_2) { image_path "darker" }

  describe 'RGB' do
    let(:options) { {} }
    subject { Imatcher.compare(path_1, path_2, options) }

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
      it "correct difference image" do
        expect(subject.difference_image).to eq(Imatcher::Image.from_file(image_path "rgb_diff"))
      end
    end
  end
end
