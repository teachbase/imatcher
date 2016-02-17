require 'spec_helper'

describe Imatcher::Matcher do
  describe "new" do
    subject { Imatcher::Matcher.new(options) }

    context "without options" do
      let(:options) { {} }

      it { expect(subject.mode.threshold).to eq 0 }
      it { expect(subject.mode).to be_a Imatcher::Modes::RGB }
    end

    context "with custom threshold" do
      let(:options) { { threshold: 0.1 } }

      it { expect(subject.mode.threshold).to eq 0.1 }
    end

    context "with custom options" do
      let(:options) { { mode: :grayscale, tolerance: 0 } }

      it { expect(subject.mode.tolerance).to eq 0 }
    end

    context "with custom mode" do
      let(:options) { { mode: :delta } }

      it { expect(subject.mode).to be_a Imatcher::Modes::Delta }
    end
  end

  describe "compare" do
    let(:path_1) { image_path "very_small" }
    let(:path_2) { image_path "very_small" }
    subject { Imatcher::Matcher.new.compare(path_1, path_2) }

    it { expect(subject).to be_a Imatcher::Result }

    context "when sizes mismatch" do
      let(:path_2) { image_path "small" }
      it { expect { subject }.to raise_error(Imatcher::SizesMismatchError) }
    end
  end
end
