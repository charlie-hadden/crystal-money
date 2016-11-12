class Money
  module Bank
    class Error < Exception; end

    abstract class Base
      def exchange_with(from : Money, to_currency : String) : Money
        exchange_with(from, Currency.find(to_currency))
      end

      abstract def exchange_with(from : Money, to_currency : Currency) : Money
    end
  end
end
