class Money
  module Bank
    class DifferentCurrencyError < Error; end

    class SingleCurrency < Base
      def exchange_with(from : Money, to_currency : Currency)
        raise DifferentCurrencyError.new("Exchanging currencies is not allowed")
      end
    end
  end
end
