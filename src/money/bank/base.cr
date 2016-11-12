class Money
  module Bank
    class Error < Exception; end
    class UnknownRate < Error; end

    abstract class Base
      def exchange_with(from : Money, to_currency : String)
        exchange_with(from, Currency.find(to_currency))
      end

      abstract def exchange_with(from : Money, to_currency : Currency)
    end
  end
end