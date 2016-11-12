require "../../spec_helper"

describe Money::Bank::VariableExchange do
  describe "#store" do
    it "should default to using the default store" do
      bank = Money::Bank::VariableExchange.new
      bank.store.should eq(Money::Config.default_rate_store)
    end

    it "should allow setting custom store" do
      store = TestStore.new
      bank = Money::Bank::VariableExchange.new(store)
      bank.store.should eq(store)
    end
  end

  describe "#exchange_with" do
    store = Money::RatesStore::Memory.new
    bank = Money::Bank::VariableExchange.new(store)
    store.add_rate("USD", "EUR", 1.33)

    it "exchanges currency" do
      bank.exchange_with(Money.new(100, "USD"), "EUR").should eq(Money.new(133, "EUR"))
    end

    it "truncates extra digests" do
      bank.exchange_with(Money.new(10, "USD"), "EUR").should eq(Money.new(13, "EUR"))
    end

    it "raises an UnknownCurrency exception when an unknown currency is used" do
      expect_raises Money::Currency::UnknownCurrency do
        bank.exchange_with(Money.new(100, "USD"), "BBB")
      end
    end

    it "raises an UnknownRate exception when an unknown rate is used" do
      expect_raises Money::RatesStore::UnknownRate do
        bank.exchange_with(Money.new(100, "USD"), "JPY")
      end
    end
  end
end
