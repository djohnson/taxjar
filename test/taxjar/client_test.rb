require "test_helper"

describe Taxjar::Client do

  describe ".sales_tax" do
    describe "v1" do
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
        @options = {
          amount: 20,
          shipping: 3,
          to_country: "US",
          to_state: "CA",
          to_city: "San Diego",
          to_zip: "92116",
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

    it "should return a TaxRate" do
      VCR.use_cassette("tax_rate") do
        response = Taxjar::Client.new.tax_rate(@options)
        response.must_be :hash
      end
    end
  end


end
