# frozen_string_literal: true

require "spec_helper"

describe Imatcher::Matcher do
  describe "new" do
    subject { Imatcher::Matcher.new(**options) }

    context "without options" do
      let(:options) { {} }

      it { expect(subject.mode.threshold).to eq 0 }
      it { expect(subject.mode).to be_a Imatcher::Modes::RGB }
    end

    context "with custom threshold" do
      let(:options) { {threshold: 0.1} }

      it { expect(subject.mode.threshold).to eq 0.1 }
    end

    context "with custom options" do
      let(:options) { {mode: :grayscale, tolerance: 0} }

      it { expect(subject.mode.tolerance).to eq 0 }
    end

    context "with custom mode" do
      let(:options) { {mode: :delta} }

      it { expect(subject.mode).to be_a Imatcher::Modes::Delta }
    end

    context "with undefined mode" do
      let(:options) { {mode: :gamma} }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe "compare" do
    let(:path_1) { image_path "very_small" }
    let(:path_2) { image_path "very_small" }
    let(:options) { {} }
    subject { Imatcher.compare(path_1, path_2, **options) }

    it { expect(subject).to be_a Imatcher::Result }

    context "when sizes mismatch" do
      let(:path_2) { image_path "small" }
      it { expect { subject }.to raise_error Imatcher::SizesMismatchError }
    end

    context "with negative exclude rect bounds" do
      let(:options) { {exclude_rect: [-1, -1, -1, -1]} }
      it { expect { subject }.to raise_error ArgumentError }
    end

    context "with big exclude rect bounds" do
      let(:options) { {exclude_rect: [100, 100, 100, 100]} }
      it { expect { subject }.to raise_error ArgumentError }
    end

    context "with negative include rect bounds" do
      let(:options) { {include_rect: [-1, -1, -1, -1]} }
      it { expect { subject }.to raise_error ArgumentError }
    end

    context "with big include rect bounds" do
      let(:options) { {include_rect: [100, 100, 100, 100]} }
      it { expect { subject }.to raise_error ArgumentError }
    end

    context "with wrong include and exclude rects combination" do
      let(:options) { {include_rect: [1, 1, 2, 2], exclude_rect: [0, 0, 1, 1]} }
      it { expect { subject }.to raise_error ArgumentError }
    end
  end
end
