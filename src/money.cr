require "./money/*"

class Money
  getter :fractional, :currency

  def self.default_currency
    # TODO: Move to config object
    "USD"
  end

  def initialize(fractional : Int, @currency : String = Money.default_currency)
    @fractional = fractional.to_u64.as(UInt64)
  end
end
