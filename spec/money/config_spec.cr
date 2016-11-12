require "../spec_helper"

describe Money::Config do
  describe ".default_currency" do
    it "should return USD" do
      Money::Config.default_currency.should eq("USD")
    end
  end

  describe ".default_bank" do
    it "should return a VariableExchange instance" do
      Money::Config.default_bank.should be_a(Money::Bank::VariableExchange)
    end
  end

  describe ".default_rate_store" do
    it "should return a Memory instance" do
      Money::Config.default_rate_store.should be_a(Money::RatesStore::Memory)
    end
  end
end
