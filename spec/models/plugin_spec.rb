require 'spec_helper'

describe Plugin do
  let(:server) { create(:server) }
  let(:website) { create(:website, server: server) }

  context "up to date" do
    subject { create(:plugin, website: website, has_update: false) }

    it "should not have an update available" do
      subject.has_update.should be_false
    end
  end

  context "out of date" do
    subject { create(:plugin, website: website, has_update: true) }

    it "should have an update available" do
      subject.has_update.should be_true
    end
  end
end