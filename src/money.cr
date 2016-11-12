require "big"
require "./money/*"

class Money
  getter :fractional, :currency

  def self.default_currency
    "USD"
  end

  def initialize(fractional : Int, currency : String = Money.default_currency)
    @fractional = fractional.to_i64.as(Int64)
    @currency = Currency.find(currency).as(Currency)
  end

  def amount
    BigFloat.new(fractional) / BigFloat.new(currency.subunit_to_unit)
  end

  def to_s
    unit, subunit = fractional.abs.divmod(currency.subunit_to_unit)
    str = "#{unit}#{currency.decimal_mark}#{pad_subunit(subunit)}"

    fractional < 0 ? "-#{str}" : str
  end

  private def pad_subunit(subunit)
    count = currency.decimal_places
    padding = "0" * count
    "#{padding}#{subunit}"[-1 * count, count]
  end
end
