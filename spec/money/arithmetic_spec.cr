require "../spec_helper"

describe Money do
  describe "#<=>" do
    it "works as intended" do
      (Money.new(-100) <=> Money.new(100)).should eq(-1)
      (Money.new(100) <=> Money.new(-100)).should eq(1)
      (Money.new(0) <=> Money.new(0)).should eq(0)
    end
  end

  describe "#<" do
    it "works as intended" do
      (Money.new(-100) < Money.new(100)).should be_true
      (Money.new(100) < Money.new(100)).should be_false
      (Money.new(100) < Money.new(-100)).should be_false
    end
  end

  describe "#<=" do
    it "works as intended" do
      (Money.new(-100) <= Money.new(100)).should be_true
      (Money.new(100) <= Money.new(100)).should be_true
      (Money.new(100) <= Money.new(-100)).should be_false
    end
  end

  describe "#==" do
    it "works as intended" do
      (Money.new(-100) == Money.new(100)).should be_false
      (Money.new(100) == Money.new(100)).should be_true
      (Money.new(100) == Money.new(-100)).should be_false
    end
  end

  describe "#>=" do
    it "works as intended" do
      (Money.new(-100) >= Money.new(100)).should be_false
      (Money.new(100) >= Money.new(100)).should be_true
      (Money.new(100) >= Money.new(-100)).should be_true
    end
  end

  describe "#>" do
    it "works as intended" do
      (Money.new(-100) > Money.new(100)).should be_false
      (Money.new(100) > Money.new(100)).should be_false
      (Money.new(100) > Money.new(-100)).should be_true
    end
  end

  describe "#+" do
    it "works as intended" do
      (Money.new(100) + Money.new(200)).should eq(Money.new(300))
    end
  end

  describe "#-" do
    it "works as intended" do
      (Money.new(100) - Money.new(200)).should eq(Money.new(-100))
    end
  end

  describe "#*" do
    it "works as intended" do
      (Money.new(200) * 2).should eq(Money.new(400))
    end
  end
end
