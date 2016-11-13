# crystal-money

A crystal library for handing money and currency, heavily influenced by the
great [RubyMoney gem for Ruby](https://github.com/RubyMoney/money). The
interface is intended to be similar but not necessarily the same.


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  money:
    github: charlie-hadden/crystal-money
```


## Usage

```crystal
require "money"

# Basic usage
money = Money.new(1000, "USD")
money.fractional #=> 1000
money.currency   #=> Money::Currency.find("USD")
money.amount     #=> BigFloat.new("10.00")
money.to_s       #=> "10.00"

# Comparisons
Money.new(1000, "USD") == Money.new(1000, "USD") #=> true
Money.new(1000, "USD") == Money.new(1000, "GBP") #=> false
Money.new(1000, "USD") == Money.new(5000, "USD") #=> false
Money.new(1000, "USD") <= Money.new(5000, "USD") #=> true

# Arithmetic
Money.new(1000, "USD") + Money.new(2000, "USD") #=> Money.new(3000, "USD")
Money.new(3000, "USD") - Money.new(2000, "USD") #=> Money.new(1000, "USD")
Money.new(3000, "USD") * 3                      #=> Money.new(9000, "USD")

# Formatting
Money.new(1000, "USD").format #=> "$10.00"
Money.new(1000, "GBP").format #=> "£10.00"
Money.new(1000, "EUR").format #=> "€10.00"

# Currency conversions
Money.new(1000, "USD").exchange_to("GBP") #=> Money.new(converted_value, "GBP")
```


## Contributing

1. Fork it ( https://github.com/charlie-hadden/money/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [charlie-hadden](https://github.com/charlie-hadden) Charlie Hadden - creator, maintainer
