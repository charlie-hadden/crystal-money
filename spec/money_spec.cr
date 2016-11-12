require "./spec_helper"

describe Money do
  describe ".new" do
    it "stores the fractional" do
      money = Money.new(1000)
      money.fractional.should eq(1000)
    end

    it "stores the fractional as a UInt64" do
      money = Money.new(1000)
      money.fractional.should be_a(UInt64)
    end

    context "a currency is not provided" do
      it "should use the default currency" do
        money = Money.new(1000)
        money.currency.should eq(Money.default_currency)
      end
    end

    context "a currency is provided" do
      it "should use the provided currency" do
        money = Money.new(1000, "GBP")
        money.currency.should eq("GBP")
      end
    end
  end
end
