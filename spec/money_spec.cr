require "./spec_helper"

describe Money do
  describe ".new" do
    context "a currency is not provided" do
      it "should use the default currency" do
        money = Money.new(1000)
        money.currency.iso_code.should eq(Money::Config.default_currency)
      end
    end

    context "a currency is provided as a string" do
      it "should use the provided currency" do
        money = Money.new(1000, "GBP")
        money.currency.iso_code.should eq("GBP")
      end
    end

    context "a currency instance is provided" do
      it "should use the provided currency" do
        money = Money.new(1000, Money::Currency.find("GBP"))
        money.currency.iso_code.should eq("GBP")
      end
    end
  end

  describe "#fractional" do
    it "stores the fractional" do
      money = Money.new(1000)
      money.fractional.should eq(1000)
    end

    it "stores the fractional as an Int64" do
      money = Money.new(1000)
      money.fractional.should be_a(Int64)
    end
  end

  describe "#amount" do
    it "returns the fractional amount as the whole amount" do
      Money.new(100).amount.should eq(1)
    end

    it "uses subunit_to_unit of currency" do
      Money.new(100, "USD").amount.should eq(1)
      Money.new(1000, "TND").amount.should eq(1)
      Money.new(1, "VUV").amount.should eq(1)
    end

    it "does not lose decimals" do
      Money.new(12345).amount.should eq(BigFloat.new("123.45"))
    end

    it "returns a BigFloat" do
      Money.new(100).amount.should be_a(BigFloat)
    end
  end

  describe "#to_s" do
    it "returns the amount as a string" do
      Money.new(100).to_s.should eq("1.00")
      Money.new(12345).to_s.should eq("123.45")
      Money.new(-12345).to_s.should eq("-123.45")
    end

    it "uses the subunit_to_unit property" do
      Money.new(1000, "BHD").to_s.should eq("1.000")
      Money.new(1000, "CNY").to_s.should eq("10.00")
    end

    it "does not work when subunit_to_unit is 5" do
      Money.new(1000, "MGA").to_s.should eq("200.0")
    end

    it "respects decimal_mark" do
      Money.new(1000, "BRL").to_s.should eq("10,00")
    end
  end
end
