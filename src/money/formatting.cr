class Money
  def format(
    decimal_mark : String = currency.decimal_mark,
    disambiguate : Bool = Config.format_disambiguate,
    display_free : String|Nil = Config.format_display_free,
    html : Bool = Config.format_html,
    no_cents : Bool = Config.format_no_cents,
    no_cents_if_whole : Bool = Config.format_no_cents_if_whole,
    sign_before_symbol : Bool = Config.format_sign_before_symbol,
    sign_positive : Bool = Config.format_sign_positive,
    south_asian_number_formatting : Bool = Config.format_south_asian_number_formatting,
    symbol : Bool|String = Config.format_symbol,
    thousands_separator : String = currency.thousands_separator,
    with_currency : Bool = Config.format_with_currency
  )
    if fractional == 0 && !display_free.nil?
      return display_free
    end

    symbol_value = symbol_value_from_rules(symbol, disambiguate, html)
    formatted = Money.new(fractional.abs, currency).to_s

    sign = fractional < 0 ? "-" : ""
    sign = "+" if sign_positive && fractional > 0

    if sign_before_symbol
      sign_before = sign
      sign = ""
    end

    if no_cents || (no_cents_if_whole && fractional % currency.subunit_to_unit == 0)
      formatted = formatted.to_i(strict: false).to_s
    end

    formatted = formatted.gsub(
      regex_format(formatted, decimal_mark, symbol_value, south_asian_number_formatting),
      "\\1#{thousands_separator}"
    )

    if symbol_value.size > 0
      if currency.symbol_first
        formatted = "#{sign_before}#{symbol_value}#{sign}#{formatted}"
      else
        formatted = "#{sign_before}#{sign}#{formatted} #{symbol_value}"
      end
    else
      formatted = "#{sign_before}#{sign}#{formatted}"
    end

    formatted = apply_decimal_mark(formatted, decimal_mark)

    formatted = "#{formatted} #{currency.iso_code}" if with_currency

    formatted
  end

  private def symbol_value_from_rules(symbol, disambiguate, html)
    return symbol if symbol.is_a?(String)
    return "" unless symbol

    if html
      currency.html_entity == "" ? currency.symbol : currency.html_entity
    elsif disambiguate && currency.disambiguate_symbol
      currency.disambiguate_symbol
    else
      currency.symbol
    end
  end

  private def regex_format(formatted, decimal_mark, symbol_value, south_asian_number_formatting)
    return /(\d+?)(?=(\d\d)+(\d)(?:\.))/ if south_asian_number_formatting

    regex_decimal = Regex.escape(decimal_mark)

    if formatted.sub(symbol_value, "") =~ /#{regex_decimal}/
      /(\d)(?=(?:\d{3})+(?:#{regex_decimal}))/
    else
      /(\d)(?=(?:\d{3})+(?:[^\d]{1}|$))/
    end
  end

  private def apply_decimal_mark(formatted, decimal_mark)
    return formatted if decimal_mark == currency.decimal_mark

    regex_decimal = Regex.escape(currency.decimal_mark)

    formatted.sub(
      /(.*)(#{regex_decimal})(.*)\Z/,
      "\\1#{decimal_mark}\\3"
    )
  end
end
