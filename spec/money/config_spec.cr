require "../spec_helper"

describe Money::Config do
  describe ".default_currency" do
    it "should return USD" do
      Money::Config.default_currency.should eq("USD")
    end
  end

  describe ".default_bank" do
    it "should return a SingleCurrency instance" do
      Money::Config.default_bank.should be_a(Money::Bank::SingleCurrency)
    end
  end
end
