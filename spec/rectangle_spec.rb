# frozen_string_literal: true

require "spec_helper"

describe Imatcher::Rectangle do
  let(:rect) { described_class.new(0, 0, 9, 9) }

  describe "area" do
    subject { rect.area }

    it { expect(subject).to eq 100 }
  end

  describe "contains?" do
    let(:rect2) { described_class.new(1, 1, 8, 8) }
    subject { rect.contains?(rect2) }

    it { expect(subject).to be_truthy }

    context "when does not contain" do
      let(:rect2) { described_class.new(2, 2, 10, 10) }

      it { expect(subject).to be_falsey }
    end
  end

  describe "contains_point?" do
    let(:point) { [5, 5] }
    subject { rect.contains_point?(*point) }

    it { expect(subject).to be_truthy }

    context "when does not contain" do
      let(:point) { [10, 10] }

      it { expect(subject).to be_falsey }
    end
  end
end
