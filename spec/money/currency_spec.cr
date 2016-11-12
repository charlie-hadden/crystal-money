require "../spec_helper"

describe Money::Currency do
  describe "UnknownCurrency" do
    it "should be a subclass of ArgumentError" do
      Money::Currency::UnknownCurrency.new.should be_a(ArgumentError)
    end
  end

  describe ".find" do
    context "when the given currency exists" do
      it "finds the currency information" do
        currency = Money::Currency.find("USD")
        currency.id.should eq("usd")
      end
    end

    context "when the given currency doesn't exist" do
      it "should raise an UnknownCurrency error" do
        expect_raises Money::Currency::UnknownCurrency do
          Money::Currency.find("FOO")
        end
      end
    end
  end

  describe ".new" do
    it "sets the expected data" do
      currency = Money::Currency.new(
        id: "FOO",
        priority: 1,
        iso_code: "FOO",
        name: "Some Test Currency",
        symbol: "$",
        disambiguate_symbol: "FOO$",
        subunit: "Cent",
        subunit_to_unit: 100.to_u32,
        symbol_first: true,
        html_entity: "$",
        decimal_mark: ".",
        thousands_separator: ",",
        iso_numeric: "840",
        smallest_denomination: 1.to_u32
      )

      currency.id.should eq("foo")
    end
  end

  describe "#decimal_places" do
    it "returns the correct number of places" do
      Money::Currency.find("USD").decimal_places.should eq(2)
      Money::Currency.find("MRO").decimal_places.should eq(1)
      Money::Currency.find("BIF").decimal_places.should eq(0)
    end
  end
end
