require "../../spec_helper"

describe Money::RatesStore::Base do
  describe "Error" do
    it "should be a subclass of Exception" do
      Money::RatesStore::Error.new.should be_a(Exception)
    end
  end

  describe "UnknownRate" do
    it "should be a subclass of Money::RatesStore::Error" do
      Money::RatesStore::UnknownRate.new.should be_a(Money::RatesStore::Error)
    end
  end
end
