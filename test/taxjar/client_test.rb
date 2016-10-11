require "test_helper"

describe Taxjar::Client do

  before do
    @options_sales_tax = {
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

    @options_tax_rate = {
      zip: "07446",
      city: "Ramsey",
      country: "US"
    }

    @options_order_transaction = {
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

    @options_refund_transaction = {
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
  end

  describe "v1" do
    before do
      Taxjar.configure do |config|
        config.api_version = 1
        config.api_tier = nil
      end
    end

    describe ".sales_tax" do
      it "should return a SalesTax" do
        VCR.use_cassette("v1/sales_tax") do
          response = Taxjar::Client.new.sales_tax(@options_sales_tax)
          response.must_be :hash
        end
      end
    end

    describe ".tax_rate" do
      it "should return a TaxRate" do
        VCR.use_cassette("v1/tax_rate") do
          response = Taxjar::Client.new.tax_rate(@options_tax_rate)
          response.must_be :hash
        end
      end
    end
  end

  describe "v2" do
    before do
      Taxjar.api_version = 2
    end

    describe "standard" do
      before do
        Taxjar.api_tier = 'standard'
      end

      describe ".sales_tax" do
        it "should return a SalesTax" do
          VCR.use_cassette("v2/standard/sales_tax") do
            response = Taxjar::Client.new.sales_tax(@options_sales_tax)
            response.must_be :hash
          end
        end
      end

      describe ".tax_rate" do
        it "should return a TaxRate" do
          VCR.use_cassette("v2/standard/tax_rate") do
            response = Taxjar::Client.new.tax_rate(@options_tax_rate)
            response.must_be :hash
          end
        end
      end
    end

    describe "enhanced" do
      before do
        Taxjar.api_tier = 'enhanced'
      end

      describe ".list_categories" do
        it "should list tax categories" do
          VCR.use_cassette("v2/enhanced/list_categories") do
            response = Taxjar::Client.new.list_categories()
            response.must_be :hash
          end
        end
      end

      describe ".create_order_transaction" do
        it "should create a new order transaction" do
          VCR.use_cassette("v2/enhanced/create_order_transaction") do
            response = Taxjar::Client.new.create_order_transaction(@options_order_transaction)
            response.must_be :hash
          end
        end
      end

      describe ".update_order_transaction" do
        it "should update order transaction" do
          VCR.use_cassette("v2/enhanced/update_order_transaction") do
            response = Taxjar::Client.new.update_order_transaction(@options_order_transaction)
            response.must_be :hash
          end
        end
      end

      describe ".delete_order_transaction" do
        it "should delete order transaction" do
          VCR.use_cassette("v2/enhanced/delete_order_transaction") do
            response = Taxjar::Client.new.delete_order_transaction(@options_order_transaction)
            response.must_be :hash
          end
        end
      end

      describe ".create_refund_transaction" do
        it "should create a new refund transaction" do
          VCR.use_cassette("v2/enhanced/create_refund_transaction") do
            response = Taxjar::Client.new.create_refund_transaction(@options_refund_transaction)
            response.must_be :hash
          end
        end
      end

      describe ".update_refund_transaction" do
        it "should update refund transaction" do
          VCR.use_cassette("v2/enhanced/update_refund_transaction") do
            response = Taxjar::Client.new.update_refund_transaction(@options_refund_transaction)
            response.must_be :hash
          end
        end
      end

      describe ".delete_refund_transaction" do
        it "should delete refund transaction" do
          VCR.use_cassette("v2/enhanced/delete_refund_transaction") do
            response = Taxjar::Client.new.delete_refund_transaction(@options_refund_transaction)
            response.must_be :hash
          end
        end
      end
    end
  end
end
