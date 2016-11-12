require "big"
require "./money/*"

class Money
  getter :fractional, :currency

  def initialize(fractional : Int, currency : String = Config.default_currency)
    initialize(fractional, Currency.find(currency))
  end

  def initialize(fractional : Int, @currency : Currency)
    @fractional = fractional.to_i64.as(Int64)
  end

  def amount
    BigFloat.new(fractional) / BigFloat.new(currency.subunit_to_unit)
  end

  def to_s(io : IO)
    unit, subunit = fractional.abs.divmod(currency.subunit_to_unit)

    str = "#{unit}#{currency.decimal_mark}#{pad_subunit(subunit)}"
    str = "-#{str}" if fractional < 0

    io << str
  end

  def inspect(io : IO)
    io << "#<" << {{@type.name.id.stringify}} << ":0x"
    object_id.to_s(16, io)
    io << " fractional: #{fractional}, currency: #{currency.iso_code}>"
  end

  private def pad_subunit(subunit)
    count = currency.decimal_places
    padding = "0" * count
    "#{padding}#{subunit}"[-1 * count, count]
  end
end
