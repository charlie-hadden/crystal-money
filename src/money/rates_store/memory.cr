class Money
  module RatesStore
    class Memory < Base
      @rates = {} of Tuple(String, String) => Float64

      def get_rate(currency_iso_from : String, currency_iso_to : String)
        @rates[{currency_iso_from, currency_iso_to}]
      rescue KeyError
        raise UnknownRate.new("Unknown exchange rate from #{currency_iso_from} to #{currency_iso_to}.")
      end

      def add_rate(currency_iso_from : String, currency_iso_to : String, rate : Float64)
        @rates[{currency_iso_from, currency_iso_to}] = rate
      end
    end
  end
end
