require "../spec_helper"

describe Money do
  describe "#format" do
    it "returns the monetary value as a string" do
      Money.new(100, "CAD").format.should eq("$1.00")
      Money.new(40008, "USD").format.should eq("$400.08")
    end

    it "uses subunit_to_unit" do
      Money.new(1000, "BHD").format.should eq("ب.د1.000")
    end

    it "does not display a decimal when subunit_to_unit is 1" do
      Money.new(1000, "VUV").format.should eq("Vt1,000")
    end

    it "respecs thousands_separator and decimal_mark defaults" do
      # Pounds
      Money.new(100000, "GBP").format.should eq("£1,000.00")

      # Dollars
      Money.new(100000, "USD").format.should eq("$1,000.00")
      Money.new(100000, "CAD").format.should eq("$1,000.00")
      Money.new(100000, "AUD").format.should eq("$1,000.00")
      Money.new(100000, "NZD").format.should eq("$1,000.00")

      # Yen
      Money.new(100000, "JPY").format.should eq("¥100,000")
      Money.new(100000, "CNY").format.should eq("¥1,000.00")

      # Euro
      Money.new(100000, "EUR").format.should eq("€1.000,00")

      # Rupees
      Money.new(100000, "INR").format.should eq("₹1,000.00")
      Money.new(100000, "NPR").format.should eq("₨1,000.00")
      Money.new(100000, "SCR").format.should eq("1,000.00 ₨")
      Money.new(100000, "LKR").format.should eq("1,000.00 ₨")

      # Brazilian Real
      Money.new(100000, "BRL").format.should eq("R$1.000,00")

      # Other
      Money.new(100000, "SEK").format.should eq("1 000,00 kr")
    end

    it "inserts thousands separator into the result for large amounts" do
      Money.new(1_000_000_000_12).format.should eq("$1,000,000,000.12")
      Money.new(1_000_000_000_12).format(no_cents: true).should eq("$1,000,000,000")

      Money.new(1_234_567_12, "EUR").format.should eq("€1.234.567,12")
      Money.new(1_234_567_12, "EUR").format(no_cents: true).should eq("€1.234.567")
    end

    context "when config format_display_free is true" do
      context "with no rule provided" do
        it "uses default rule" do
          with_format_display_free do
            Money.new(0, "USD").format.should eq("FREE")
          end
        end
      end

      context "with display_free: false provided" do
        it "uses provideded rule" do
          with_format_display_free do
            Money.new(0, "USD").format(display_free: nil).should eq("$0.00")
          end
        end
      end
    end

    describe "with_currency option" do
      it "works as expected" do
        Money.new(100, "CAD").format(with_currency: true).should eq("$1.00 CAD")
        Money.new(85, "USD").format(with_currency: true).should eq("$0.85 USD")
      end
    end

    describe "no_cents option" do
      it "works as expected" do
        Money.new(100).format(no_cents: true).should eq("$1")
        Money.new(599).format(no_cents: true).should eq("$5")
        Money.new(570).format(no_cents: true, with_currency: true).should eq("$5 USD")
        Money.new(39000).format(no_cents: true).should eq("$390")
      end

      it "uses subunit_to_unit properly" do
        Money.new(1000, "BHD").format(no_cents: true).should eq("ب.د1")
      end

      it "inserts thousand separators if symbol contains decimal mark and no_cents is true" do
        Money.new(100000000, "AMD").format(no_cents: true).should eq("1,000,000 դր.")
        Money.new(100000000, "USD").format(no_cents: true).should eq("$1,000,000")
        Money.new(100000000, "RUB").format(no_cents: true).should eq("1.000.000 ₽")
      end

      it "correctly formats HTML" do
        Money.new(1999, "RUB").format(html: true, no_cents: true).should eq("19 &#x20BD;")
      end
    end

    describe "no_cents_if_whole option" do
      it "works as expected when set to true" do
        Money.new(10000, "VUV").format(no_cents_if_whole: true, symbol: false).should eq("10,000")
        Money.new(10034, "VUV").format(no_cents_if_whole: true, symbol: false).should eq("10,034")
        Money.new(10000, "MGA").format(no_cents_if_whole: true, symbol: false).should eq("2,000")
        Money.new(10034, "MGA").format(no_cents_if_whole: true, symbol: false).should eq("2,006.4")
        Money.new(10000, "VND").format(no_cents_if_whole: true, symbol: false).should eq("10.000")
        Money.new(10034, "VND").format(no_cents_if_whole: true, symbol: false).should eq("10.034")
        Money.new(10000, "USD").format(no_cents_if_whole: true, symbol: false).should eq("100")
        Money.new(10034, "USD").format(no_cents_if_whole: true, symbol: false).should eq("100.34")
        Money.new(10000, "IQD").format(no_cents_if_whole: true, symbol: false).should eq("10")
        Money.new(10034, "IQD").format(no_cents_if_whole: true, symbol: false).should eq("10.034")
      end

      it "works as expected when set to false" do
        Money.new(10000, "VUV").format(no_cents_if_whole: false, symbol: false).should eq("10,000")
        Money.new(10034, "VUV").format(no_cents_if_whole: false, symbol: false).should eq("10,034")
        Money.new(10000, "MGA").format(no_cents_if_whole: false, symbol: false).should eq("2,000.0")
        Money.new(10034, "MGA").format(no_cents_if_whole: false, symbol: false).should eq("2,006.4")
        Money.new(10000, "VND").format(no_cents_if_whole: false, symbol: false).should eq("10.000")
        Money.new(10034, "VND").format(no_cents_if_whole: false, symbol: false).should eq("10.034")
        Money.new(10000, "USD").format(no_cents_if_whole: false, symbol: false).should eq("100.00")
        Money.new(10034, "USD").format(no_cents_if_whole: false, symbol: false).should eq("100.34")
        Money.new(10000, "IQD").format(no_cents_if_whole: false, symbol: false).should eq("10.000")
        Money.new(10034, "IQD").format(no_cents_if_whole: false, symbol: false).should eq("10.034")
      end
    end

    describe "symbol option" do
      it "uses the provided string" do
        Money.new(100, "GBP").format(symbol: "$").should eq("$1.00")
      end

      it "returns the symbol from the currency when true" do
        # Pounds
        Money.new(100, "GBP").format(symbol: true).should eq("£1.00")

        # Dollars
        Money.new(100, "USD").format(symbol: true).should eq("$1.00")
        Money.new(100, "CAD").format(symbol: true).should eq("$1.00")
        Money.new(100, "AUD").format(symbol: true).should eq("$1.00")
        Money.new(100, "NZD").format(symbol: true).should eq("$1.00")

        # Yen
        Money.new(100, "JPY").format(symbol: true).should eq("¥100")
        Money.new(100, "CNY").format(symbol: true).should eq("¥1.00")

        # Euro
        Money.new(100, "EUR").format(symbol: true).should eq("€1,00")

        # Rupees
        Money.new(100, "INR").format(symbol: true).should eq("₹1.00")
        Money.new(100, "NPR").format(symbol: true).should eq("₨1.00")
        Money.new(100, "SCR").format(symbol: true).should eq("1.00 ₨")
        Money.new(100, "LKR").format(symbol: true).should eq("1.00 ₨")

        # Brazilian Real
        Money.new(100, "BRL").format(symbol: true).should eq("R$1,00")

        # Other
        Money.new(100, "SEK").format(symbol: true).should eq("1,00 kr")
      end

      it "returns amount without a symbol when false" do
        Money.new(100, "GBP").format(symbol: false).should eq("1.00")
        Money.new(-100, "GBP").format(symbol: false).should eq("-1.00")
        Money.new(100, "GBP").format(symbol: false, sign_positive: true).should eq("+1.00")
      end
    end

    describe "decimal_mark option" do
      it "works as expected" do
        Money.new(100, "USD").format(decimal_mark: ",").should eq("$1,00")
      end
    end

    describe "south_asian_number_formatting option" do
      it "works as expected" do
        Money.new(10000000, "INR").format(south_asian_number_formatting: true, symbol: false).should eq("1,00,000.00")
        Money.new(10000000, "USD").format(south_asian_number_formatting: true).should eq("$1,00,000.00")
      end
    end

    describe "thousands_separator option" do
      it "works as expected when a string is provided" do
        Money.new(100000).format(thousands_separator: ".").should eq("$1.000.00")
        Money.new(200000).format(thousands_separator: "").should eq("$2000.00")
      end
    end

    describe "thousands_separator and decimal_mark options" do
      it "works as expected when both are strings" do
        Money.new(123456789, "USD").format(thousands_separator: ".", decimal_mark: ",").should eq("$1.234.567,89")
        Money.new(987654321, "USD").format(thousands_separator: " ", decimal_mark: ".").should eq("$9 876 543.21")
      end
    end

    describe "html option" do
      it "works as expected when true" do
        Money.new(1000, "USD").format(html: true).should eq("$10.00")
        Money.new(1000, "ANG").format(html: true).should eq("&#x0192;10,00")
      end

      it "falls back to symbol when entity is not available" do
        Money.new(570, "DKK").format(html: true).should eq("5,70 kr.")
      end
    end

    describe "sign_before_symbol option" do
      it "works as expected" do
        Money.new(-100000, "USD").format(sign_before_symbol: true).should eq("-$1,000.00")
        Money.new(-100000, "USD").format(sign_before_symbol: false).should eq("$-1,000.00")
        Money.new(-100000, "USD").format.should eq("$-1,000.00")
      end
    end

    describe "sign_positive option" do
      it "works when sign_before_symbol is true" do
        Money.new(0, "USD").format(sign_positive: true, sign_before_symbol: true).should eq("$0.00")
        Money.new(100000, "USD").format(sign_positive: true, sign_before_symbol: true).should eq("+$1,000.00")
        Money.new(-100000, "USD").format(sign_positive: true, sign_before_symbol: true).should eq("-$1,000.00")
      end

      it "works when sign_before_symbol is false" do
        Money.new(0, "USD").format(sign_positive: true, sign_before_symbol: false).should eq("$0.00")
        Money.new(100000, "USD").format(sign_positive: true, sign_before_symbol: false).should eq("$+1,000.00")
        Money.new(-100000, "USD").format(sign_positive: true, sign_before_symbol: false).should eq("$-1,000.00")
      end
    end

    describe "disambiguate option" do
      it "returns ambiguous signs by default" do
        Money.new(1999_98, "USD").format.should eq("$1,999.98")
        Money.new(1999_98, "CAD").format.should eq("$1,999.98")
        Money.new(1999_98, "DKK").format.should eq("1.999,98 kr.")
        Money.new(1999_98, "NOK").format.should eq("1.999,98 kr")
        Money.new(1999_98, "SEK").format.should eq("1 999,98 kr")
      end

      it "returns ambiguous signs when set to false" do
        Money.new(1999_98, "USD").format(disambiguate: false).should eq("$1,999.98")
        Money.new(1999_98, "CAD").format(disambiguate: false).should eq("$1,999.98")
        Money.new(1999_98, "DKK").format(disambiguate: false).should eq("1.999,98 kr.")
        Money.new(1999_98, "NOK").format(disambiguate: false).should eq("1.999,98 kr")
        Money.new(1999_98, "SEK").format(disambiguate: false).should eq("1 999,98 kr")
      end

      it "returns disambiguate signs when disambiguate is true" do
        Money.new(1999_98, "USD").format(disambiguate: true).should eq("US$1,999.98")
        Money.new(1999_98, "CAD").format(disambiguate: true).should eq("C$1,999.98")
        Money.new(1999_98, "DKK").format(disambiguate: true).should eq("1.999,98 DKK")
        Money.new(1999_98, "NOK").format(disambiguate: true).should eq("1.999,98 NOK")
        Money.new(1999_98, "SEK").format(disambiguate: true).should eq("1 999,98 SEK")
      end

      it "returns disambiguate signs when disambiguate is true and symbol is true" do
        Money.new(1999_98, "USD").format(disambiguate: true, symbol: true).should eq("US$1,999.98")
        Money.new(1999_98, "CAD").format(disambiguate: true, symbol: true).should eq("C$1,999.98")
        Money.new(1999_98, "DKK").format(disambiguate: true, symbol: true).should eq("1.999,98 DKK")
        Money.new(1999_98, "NOK").format(disambiguate: true, symbol: true).should eq("1.999,98 NOK")
        Money.new(1999_98, "SEK").format(disambiguate: true, symbol: true).should eq("1 999,98 SEK")
      end

      it "returns disambiguate signs when disambiguate is true and symbol is false" do
        Money.new(1999_98, "USD").format(disambiguate: true, symbol: false).should eq("1,999.98")
        Money.new(1999_98, "CAD").format(disambiguate: true, symbol: false).should eq("1,999.98")
        Money.new(1999_98, "DKK").format(disambiguate: true, symbol: false).should eq("1.999,98")
        Money.new(1999_98, "NOK").format(disambiguate: true, symbol: false).should eq("1.999,98")
        Money.new(1999_98, "SEK").format(disambiguate: true, symbol: false).should eq("1 999,98")
      end
    end
  end
end
