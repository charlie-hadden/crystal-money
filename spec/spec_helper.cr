require "spec"
require "../src/money"

class TestBank < Money::Bank::Base
  getter :money, :to_currency

  def exchange_with(@money : Money, @to_currency : Money::Currency)
    Money.new(0)
  end
end

class TestStore < Money::RatesStore::Base
  def get_rate(currency_iso_from : String, currency_iso_to : String)
    2.0
  end

  def add_rate(currency_iso_from : String, currency_iso_to : String, rate : Float64)
    2.0
  end
end

def with_format_display_free
  format = Money::Config.format_display_free
  Money::Config.format_display_free = "FREE"
  yield
ensure
  Money::Config.format_display_free = format
end
