class Money
  module RatesStore
    class Error < Exception; end

    class UnknownRate < Error; end

    abstract class Base
      abstract def get_rate(currency_iso_from : String, currency_iso_to : String) : Float64
      abstract def add_rate(currency_iso_from : String, currency_iso_to : String, rate : Float64) : Float64
    end
  end
end
