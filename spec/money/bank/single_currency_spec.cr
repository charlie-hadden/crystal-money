require "../../spec_helper"

describe Money::Bank::SingleCurrency do
  describe "DifferentCurrencyError" do
    it "should be a subclass of Money::Bank::Error" do
      Money::Bank::DifferentCurrencyError.new.should be_a(Money::Bank::Error)
    end
  end

  describe "#exchange_with" do
    it "should raise a DifferentCurrencyError" do
      bank = Money::Bank::SingleCurrency.new

      expect_raises Money::Bank::DifferentCurrencyError do
        bank.exchange_with(Money.new(100, "USD"), "GBP")
      end
    end
  end
end
