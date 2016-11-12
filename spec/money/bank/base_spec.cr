require "../../spec_helper"

describe Money::Bank::Base do
  describe "Error" do
    it "should be a subclass of Exception" do
      Money::Bank::Error.new.should be_a(Exception)
    end
  end

  describe "UnknownRate" do
    it "should be a subclass of Money::Bank::Error" do
      Money::Bank::UnknownRate.new.should be_a(Money::Bank::Error)
    end
  end
end
