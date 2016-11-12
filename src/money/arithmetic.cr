class Money
  include Comparable(Money)

  def <=>(other : Money)
    fractional <=> other.exchange_to(currency).fractional
  end

  def +(other : Money)
    Money.new(fractional + other.exchange_to(currency).fractional, currency)
  end

  def -(other : Money)
    Money.new(fractional - other.exchange_to(currency).fractional, currency)
  end

  def *(other : Int)
    Money.new(fractional * other, currency)
  end
end
