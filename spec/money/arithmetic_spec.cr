require "../spec_helper"

describe Money do
  describe "#<=>" do
    it "works as intended" do
      (Money.new(-100) <=> Money.new(100)).should eq(-1)
      (Money.new(100) <=> Money.new(-100)).should eq(1)
      (Money.new(0) <=> Money.new(0)).should eq(0)
    end

    it "works with different currencies" do
      bank = TestBank.new

      (Money.new(100, "USD") <=> Money.new(100, "GBP", bank)).should_not eq(0)

      bank.money.should_not be_nil
      bank.to_currency.should_not be_nil
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

    it "works with different currencies" do
      bank = TestBank.new

      (Money.new(100, "USD") + Money.new(100, "GBP", bank)).should_not eq(Money.new(200, "USD"))

      bank.money.should_not be_nil
      bank.to_currency.should_not be_nil
    end
  end

  describe "#-" do
    it "works as intended" do
      (Money.new(100) - Money.new(200)).should eq(Money.new(-100))
    end

    it "works with different currencies" do
      bank = TestBank.new

      (Money.new(200, "USD") - Money.new(100, "GBP", bank)).should_not eq(Money.new(100, "USD"))

      bank.money.should_not be_nil
      bank.to_currency.should_not be_nil
    end
  end

  describe "#*" do
    it "works as intended" do
      (Money.new(200) * 2).should eq(Money.new(400))
    end
  end
end
