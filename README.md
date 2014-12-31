# Taxjar

Taxjar is a Ruby API wrapper for Taxjar's sales tax and tax rate API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'taxjar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taxjar

## Usage

Please reference the Taxjar [API Documentation](http://www.taxjar.com/api/docs/)

Configuration:
```ruby
Taxjar.configure do |config|
  config.auth_token = "authtokenstring"
end
```


Sales tax:

```ruby
options = {
  amount: 10,
  shipping: 2,
  to_country: "US",
  to_state: "NJ",
  to_city: "Freehold",
  to_zip: "07728",
  from_country: "US",
  from_state: "NJ",
  from_city: "Ramsey",
  from_zip: "07446"
}
response = Taxjar.client.sales_tax(options)
#  => {"amount_to_collect"=>0.84, "rate"=>0.07, "has_nexus"=>true, "freight_taxable"=>true, "tax_source"=>"destination"}
```

Tax rate lookup:

```ruby
options = {
  zip: "07446",
  city: "Ramsey",
  country: "US"
}
response = Taxjar.client.tax_rate(options)
#  {"location"=>{"state"=>"NJ", "zip"=>"07446", "state_rate"=>"0.07", "city"=>"RAMSEY", "city_rate"=>"0.0", "county"=>"BERGEN", "county_rate"=>"0.0", "combined_district_rate"=>"0.0", "combined_rate"=>"0.07"}}
```

## Contributing

1. Fork it ( https://github.com/djohnson/taxjar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
