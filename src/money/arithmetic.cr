# TODO: Handle different currencies
class Money
  include Comparable(Money)

  def <=>(other : Money)
    fractional <=> other.fractional
  end

  def +(other : Money)
    Money.new(fractional + other.fractional, currency)
  end

  def -(other : Money)
    Money.new(fractional - other.fractional, currency)
  end

  def *(other : Int)
    Money.new(fractional * other, currency)
  end
end
