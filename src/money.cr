require "big"
require "./money/*"
require "./money/bank/*"
require "./money/rates_store/*"

class Money
  getter :fractional, :currency

  def initialize(
                 fractional : Int,
                 currency : String = Config.default_currency,
                 bank : Bank::Base = Config.default_bank)
    initialize(fractional, Currency.find(currency), bank)
  end

  def initialize(
                 fractional : Int,
                 @currency : Currency,
                 @bank : Bank::Base = Config.default_bank)
    @fractional = fractional.to_i64.as(Int64)
  end

  def amount
    BigFloat.new(fractional) / BigFloat.new(currency.subunit_to_unit)
  end

  def exchange_to(to_currency : String)
    exchange_to(Currency.find(to_currency))
  end

  def exchange_to(to_currency : Currency) : Money
    if currency == to_currency
      self
    else
      @bank.exchange_with(self, to_currency)
    end
  end

  def to_s(io : IO)
    unit, subunit = fractional.abs.divmod(currency.subunit_to_unit)

    io << "-" if fractional < 0
    io << unit

    decimals = currency.decimal_places

    if decimals > 0
      padding = "0" * decimals
      io << currency.decimal_mark
      io << "#{padding}#{subunit}"[-1 * decimals, decimals]
    end
  end

  def inspect(io : IO)
    io << "#<" << {{@type.name.id.stringify}} << ":0x"
    object_id.to_s(16, io)
    io << " fractional: #{fractional}, currency: #{currency.iso_code}>"
  end

  private def format_decimal(subunit)
  end
end
