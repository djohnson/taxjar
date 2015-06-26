require "test_helper"

describe Taxjar::Client do

  describe ".sales_tax" do
    before do
      @options = {
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
    end

    describe "v1" do
      before do
        Taxjar.configure do |config|
          config.api_version = 1
          config.api_tier = nil
        end
      end

      it "should return a SalesTax" do
        VCR.use_cassette("sales_tax_v1") do
          response = Taxjar::Client.new.sales_tax(@options)
          response.must_be :hash
        end
      end
    end

    describe "v2" do
      before do
        Taxjar.configure do |config|
          config.api_version = 2
          config.api_tier = 'standard'
        end
      end

      it "should return a SalesTax" do
        VCR.use_cassette("sales_tax_v2") do
          response = Taxjar::Client.new.sales_tax(@options)
          response.must_be :hash
        end
      end
    end
  end

  describe ".tax_rate" do
    before do
      @options = {
        zip: "07446",
        city: "Ramsey",
        country: "US"
      }
    end

    describe "v1" do
      before do
        Taxjar.configure do |config|
          config.api_version = 1
          config.api_tier = nil
        end
      end

      it "should return a TaxRate" do
        VCR.use_cassette("tax_rate_v1") do
          response = Taxjar::Client.new.tax_rate(@options)
          response.must_be :hash
        end
      end
    end

    describe "v2" do
      before do
        Taxjar.configure do |config|
          config.api_version = 2
          config.api_tier = 'standard'
        end
      end

      it "should return a SalesTax" do
        VCR.use_cassette("tax_rate_v2") do
          response = Taxjar::Client.new.tax_rate(@options)
          response.must_be :hash
        end
      end
    end
  end

  describe ".create_order_transaction" do
    before do
      @options = {
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

      Taxjar.configure do |config|
        config.api_version = 2
        config.api_tier = 'enhanced'
      end
    end

    it "should create a new order transaction" do
      VCR.use_cassette("create_order_transaction_v2") do
        response = Taxjar::Client.new.create_order_transaction(@options)
        response.must_be :hash
      end
    end
  end
end
