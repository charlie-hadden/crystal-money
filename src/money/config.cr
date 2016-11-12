class Money
  class Config
    macro config(name, type, default)
      @@{{name}} : {{type}} = {{default}}

      def self.{{name}}
        @@{{name}}
      end

      def self.{{name}}=(value : {{type}})
        @@{{name}} = value
      end
    end

    config default_currency, String, "USD"
    config default_bank, Bank::Base, Bank::SingleCurrency.new
  end
end
