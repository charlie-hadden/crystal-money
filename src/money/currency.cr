class Money
  class Currency
    class UnknownCurrency < ArgumentError; end

    @@currencies = {} of String => Currency

    def self.find(id : String)
      @@currencies[id.downcase]
    rescue KeyError
      raise UnknownCurrency.new("Currency #{id} could not be found.")
    end

    getter :id, :name, :iso_code, :iso_numeric, :priority, :symbol,
      :disambiguate_symbol, :symbol_first, :subunit, :subunit_to_unit,
      :html_entity, :decimal_mark, :thousands_separator, :smallest_denomination

    {{ run("../../data/currency_loader") }}

    def initialize(
      id : String,
      @name : String,
      @iso_code : String,
      @iso_numeric : String,
      @priority : Int32,
      @symbol : String,
      @disambiguate_symbol : String,
      @symbol_first : Bool,
      @subunit : String,
      @subunit_to_unit : UInt32,
      @html_entity : String,
      @decimal_mark : String,
      @thousands_separator : String,
      @smallest_denomination : UInt32
    )
      @id = id.downcase.as(String)
      @@currencies[@id] = self
    end
  end
end
