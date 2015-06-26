# Taxjar

Taxjar is a Ruby API wrapper for Taxjar's v1 and v2 API, supporting both Standard and Enhanced API tiers.

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

Please reference the Taxjar [API Documentation](http://developers.taxjar.com/api/)

### Configuration

```ruby
Taxjar.configure do |config|
  config.auth_token = "authtokenstring"
  config.api_version = 2 # use 1 for legacy v1 API
  config.api_tier = 'enhanced' # use 'standard' for standard API
end
```

### Sales tax

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
#  => {"tax":{"taxable_amount":"12.0","amount_to_collect":0.84,"rate":0.07,"has_nexus":true,"freight_taxable":true,"tax_source":"destination"}}
```

### Tax rate lookup

```ruby
options = {
  zip: "07446",
  city: "Ramsey",
  country: "US"
}
response = Taxjar.client.tax_rate(options)
#  => {"rate":{"zip":"07446","state":"NJ","state_rate":"0.07","county":"BERGEN","county_rate":"0.0","city":"RAMSEY","city_rate":"0.0","combined_district_rate":"0.0","combined_rate":"0.07"}}
```

### List tax categories
(Enhanced API tier)

```ruby
response = Taxjar.client.new.list_categories()
#  => {"categories":[{"name":"Other Exempt","product_tax_code":"99999","description":"item is exempt"}, ... ]}
```

### Create order transaction
(Enhanced API tier)

```ruby
options = {
  transaction_id: "123456",
  transaction_date: "2015/06/26",
  amount: 10,
  shipping: 2,
  sales_tax: 0.84,
  to_country: "US",
  to_state: "NJ",
  to_city: "Freehold",
  to_zip: "07728",
  from_country: "US",
  from_state: "CA",
  from_city: "Camarillo",
  from_zip: "93010",
  line_items: [
    {
      id: 123456,
      unit_price: 20,
      quantity: 1
    }
  ]
}
response = Taxjar::Client.new.create_order_transaction(options)
#  => {"order":{"transaction_id":"123456","user_id":440,"transaction_date":"2015-06-26T00:00:00Z","from_country":"US","from_zip":"93010","from_state":"CA","from_city":"CAMARILLO","from_street":null,"to_country":"US","to_zip":"07728","to_state":"NJ","to_city":"FREEHOLD","to_street":null,"amount":"10.0","shipping":"2.0","sales_tax":"0.84","line_items":[{"id":1,"quantity":1,"product_identifier":null,"product_tax_code":null,"description":null,"unit_price":"20.0","discount":"0.0","sales_tax":"0.0"}]}}
```

### Update order transaction
(Enhanced API tier)

```ruby
options = {
  transaction_id: "123456",
  sales_tax: 0.94,
}
response = Taxjar::Client.new.update_order_transaction(options)
#  => {"order":{"transaction_id":"123456","user_id":440,"transaction_date":"2015-06-26T00:00:00Z","from_country":"US","from_zip":"93010","from_state":"CA","from_city":"CAMARILLO","from_street":null,"to_country":"US","to_zip":"07728","to_state":"NJ","to_city":"FREEHOLD","to_street":null,"amount":"10.0","shipping":"2.0","sales_tax":"0.94","line_items":[{"id":1,"quantity":1,"product_identifier":null,"product_tax_code":null,"description":null,"unit_price":"20.0","discount":"0.0","sales_tax":"0.0"}]}}
```

### Create refund transaction
(Enhanced API tier)

```ruby
options = {
  transaction_id: "REFUND_123456",
  transaction_date: "2015/06/26",
  transaction_reference_id: "123456",
  amount: 10,
  shipping: 2,
  sales_tax: 0.84,
  to_country: "US",
  to_state: "NJ",
  to_city: "Freehold",
  to_zip: "07728",
  from_country: "US",
  from_state: "CA",
  from_city: "Camarillo",
  from_zip: "93010",
  line_items: [
    {
      id: 123456,
      unit_price: 20,
      quantity: 1
    }
  ]
}
response = Taxjar::Client.new.create_refund_transaction(options)
#  => {"refund":{"transaction_id":"REFUND_123456","user_id":440,"transaction_date":"2015-06-26T00:00:00Z","transaction_reference_id":"123456","from_country":"US","from_zip":"93010","from_state":"CA","from_city":"CAMARILLO","from_street":null,"to_country":"US","to_zip":"07728","to_state":"NJ","to_city":"FREEHOLD","to_street":null,"amount":"10.0","shipping":"2.0","sales_tax":"0.84","line_items":[{"id":1,"quantity":1,"product_identifier":null,"product_tax_code":null,"description":null,"unit_price":"20.0","discount":"0.0","sales_tax":"0.0"}]}}
```

### Update refund transaction
(Enhanced API tier)

```ruby
options = {
  transaction_id: "REFUND_123456",
  sales_tax: 0.94,
}
response = Taxjar::Client.new.update_refund_transaction(options)
#  => {"order":{"transaction_id":"123456","user_id":440,"transaction_date":"2015-06-26T00:00:00Z","from_country":"US","from_zip":"93010","from_state":"CA","from_city":"CAMARILLO","from_street":null,"to_country":"US","to_zip":"07728","to_state":"NJ","to_city":"FREEHOLD","to_street":null,"amount":"10.0","shipping":"2.0","sales_tax":"0.94","line_items":[{"id":1,"quantity":1,"product_identifier":null,"product_tax_code":null,"description":null,"unit_price":"20.0","discount":"0.0","sales_tax":"0.0"}]}}
```

## Contributing

1. Fork it ( https://github.com/djohnson/taxjar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
