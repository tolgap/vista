require 'spec_helper'

describe Website do
  let(:server) { create(:server) }

  context "up to date" do
    subject { create(:website, has_update: false) }

    it "should not have an update available" do
      subject.has_update.should be_false
    end
  end

  context "out of date" do
    subject { create(:website, has_update: true) }

    it "should have an update available" do
      subject.has_update.should be_true
    end

    it "should report plugin updates" do
      subject.plugins << create(:plugin, website: subject,
        has_update: true, status: 'active')
      subject.plugins << create(:plugin, website: subject,
        has_update: false, status: 'active')

      subject.has_plugin_update.should be_true
    end
  end

  context "plugin matching" do
    let(:website) { create(:website, server: server) }
    let(:match) { create(:website, server: server) }
    let(:unmatched) { create(:website, server: server) }
    let(:plugin) { create(:plugin, website: website, name: 'hello') }

    before do
      create(:plugin, website: match, name: 'hello')
      create(:plugin, website: unmatched, name: 'world')
    end

    it "should match website with same plugin" do
      Website.has_plugin(plugin).should =~ match.plugins
    end

    it "should not match website without plugin" do
      Website.has_plugin(plugin).should_not =~ unmatched.plugins
    end
  end
end