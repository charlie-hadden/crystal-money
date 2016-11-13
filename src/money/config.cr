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
    config default_bank, Bank::Base, Bank::VariableExchange.new
    config default_rate_store, RatesStore::Base, RatesStore::Memory.new

    config format_disambiguate, Bool, false
    config format_display_free, String|Nil, nil
    config format_html, Bool, false
    config format_no_cents, Bool, false
    config format_no_cents_if_whole, Bool, false
    config format_sign_before_symbol, Bool, false
    config format_sign_positive, Bool, false
    config format_south_asian_number_formatting, Bool, false
    config format_symbol, Bool|String, true
    config format_with_currency, Bool, false
  end
end
