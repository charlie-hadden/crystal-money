require "json"

json = File.read(File.join(__DIR__, "currency_iso.json"))

JSON.parse(json).each do |id, currency|
  smallest_denomination = currency["smallest_denomination"]?

  if smallest_denomination.nil? || smallest_denomination.raw.is_a?(String)
    smallest_denomination = 0
  end

  puts <<-CURRENCY
    Currency.new(
      id: "#{id}",
      priority: #{currency["priority"]},
      iso_code: "#{currency["iso_code"]}",
      name: "#{currency["name"]}",
      symbol: "#{currency["symbol"]}",
      disambiguate_symbol: "#{currency["disambiguate_symbol"]?}",
      subunit: "#{currency["subunit"]}",
      subunit_to_unit: #{currency["subunit_to_unit"]}.to_u32,
      symbol_first: #{currency["symbol_first"]},
      html_entity: "#{currency["html_entity"]}",
      decimal_mark: "#{currency["decimal_mark"]}",
      thousands_separator: "#{currency["thousands_separator"]}",
      iso_numeric: "#{currency["iso_numeric"]}",
      smallest_denomination: #{smallest_denomination}.to_u32
    )
    CURRENCY
end
