require "../../spec_helper"

describe Money::RatesStore::Memory do
  describe "#add_rate and #get_rate" do
    it "should return the rate if it exists" do
      store = Money::RatesStore::Memory.new
      store.add_rate("USD", "GBP", 0.5).should eq(0.5)
      store.get_rate("USD", "GBP").should eq(0.5)
    end
  end

  describe "#get_rate" do
    it "should raise an UnknownRate error if the rate can't be found" do
      store = Money::RatesStore::Memory.new
      expect_raises Money::RatesStore::UnknownRate do
        store.get_rate("USD", "GBP")
      end
    end
  end
end
