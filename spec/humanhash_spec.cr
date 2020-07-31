require "./spec_helper"

describe HumanHash do
  hex_digest = "535061bddb0549f691c8b9c012a55ee2"

  describe "#uuid" do
    it "should return an Array containing a HumanHash and its digest" do
      h = HumanHash.uuid
      HumanHash.humanize(h.digest).should eq(h.human)
    end
  end

  describe "#humanize" do
    it "should accept a hex digest and return a HumanHash" do
      HumanHash.humanize(hex_digest).should eq("adrift-torpedo-peachy-tomorrow")
    end

    it "should accept a separator" do
      HumanHash.humanize(hex_digest, separator: "_").should eq("adrift_torpedo_peachy_tomorrow")
    end
  end
end

describe "HumanHash::HumanHasher" do
  hex_digest = "535061bddb0549f691c8b9c012a55ee2"

  it "should accept a wordlist" do
    word_list = (0..300).map { |v| {"a#{v}", "b#{v}"} }
    HumanHash::HumanHasher.new(word_list: word_list).humanize(hex_digest).should eq("a4-b227-a144-b226")
  end

  describe "#uuid" do
    it "should return an Array containing a HumanHash and its UUID" do
      h = HumanHash::HumanHasher.new.uuid
      HumanHash.humanize(h.digest).should eq(h.human)
    end

    it "should accept a separator" do
      HumanHash::HumanHasher.new(separator: "_").uuid.human.should match(/\w+_\w+_\w+_\w+/)
    end
  end

  describe "#humanize" do
    it "should accept a hex digest and return a HumanHash" do
      HumanHash::HumanHasher.new.humanize(hex_digest).should eq("adrift-torpedo-peachy-tomorrow")
    end

    it "should accept a separator" do
      HumanHash::HumanHasher.new(separator: "_").humanize(hex_digest).should eq("adrift_torpedo_peachy_tomorrow")
    end
  end
end
