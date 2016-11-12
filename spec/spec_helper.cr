require "spec"
require "../src/money"

class TestBank < Money::Bank::Base
  getter :money, :to_currency

  def exchange_with(@money : Money, @to_currency : Money::Currency); end
end
