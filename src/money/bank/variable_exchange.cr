class Money
  module Bank
    class VariableExchange < Base
      getter :store

      def initialize(@store : RatesStore::Base = Config.default_rate_store)
      end

      def exchange_with(from : Money, to_currency : Currency)
        if from.currency == to_currency
          from
        else
          rate = store.get_rate(from.currency.iso_code, to_currency.iso_code)
          fractional = BigFloat.new(from.fractional) / (BigFloat.new(from.currency.subunit_to_unit) / BigFloat.new(to_currency.subunit_to_unit))
          Money.new((fractional * BigFloat.new(rate)).to_u64, to_currency)
        end
      end
    end
  end
end
