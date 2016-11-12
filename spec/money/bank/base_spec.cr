require "../../spec_helper"

describe Money::Bank::Base do
  describe "Error" do
    it "should be a subclass of Exception" do
      Money::Bank::Error.new.should be_a(Exception)
    end
  end
end
