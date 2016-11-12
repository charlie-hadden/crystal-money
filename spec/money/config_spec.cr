require "../spec_helper"

describe Money::Config do
  describe ".default_currency" do
    it "should return USD" do
      Money::Config.default_currency.should eq("USD")
    end
  end
end
