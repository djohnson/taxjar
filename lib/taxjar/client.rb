require "faraday"
require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Taxjar
  class Client

    attr_accessor *Configuration::VALID_CONFIG_KEYS
    attr_reader :conn

    def initialize(options={})
      options = Taxjar.options.merge(options)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", options[key])
      end

      check_configuration
      setup_conn
    end

    def sales_tax(options={})
      case api_version
      when 1
        response = @conn.get api_path('sales_tax'), options
      when 2
        response = @conn.post api_path('taxes'), options
      end
      response.body
    end

    def tax_rate(options={})
      case api_version
      when 1
        response = @conn.get "/locations/#{options.delete(:zip)}", options
      when 2
        response = @conn.get api_path('rates', options.delete(:zip)), options
      end
      response.body
    end

    def list_categories()
      check_availability(method_api_version: 2, method_api_tier: 'enhanced')
      response = @conn.get api_path('categories')
      response.body
    end

    def create_order_transaction(options={})
      check_availability(method_api_version: 2, method_api_tier: 'enhanced')
      response = @conn.post api_path('transactions', 'orders'), options
      response.body
    end

    def update_order_transaction(options={})
      check_availability(method_api_version: 2, method_api_tier: 'enhanced')
      response = @conn.put api_path('transactions', 'orders', options.delete(:transaction_id)), options
      response.body
    end

    def delete_order_transaction(options={})
      check_availability(method_api_version: 2, method_api_tier: 'enhanced')
      response = @conn.delete api_path('transactions', 'orders', options.delete(:transaction_id)), options
      response.body
    end

    def create_refund_transaction(options={})
      check_availability(method_api_version: 2, method_api_tier: 'enhanced')
      response = @conn.post api_path('transactions', 'refunds'), options
      response.body
    end

    def update_refund_transaction(options={})
      check_availability(method_api_version: 2, method_api_tier: 'enhanced')
      response = @conn.put api_path('transactions', 'refunds', options.delete(:transaction_id)), options
      response.body
    end

    def delete_refund_transaction(options={})
      check_availability(method_api_version: 2, method_api_tier: 'enhanced')
      response = @conn.delete api_path('transactions', 'refunds', options.delete(:transaction_id)), options
      response.body
    end

    private

    def setup_conn
      options = {
        :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
        :proxy => proxy,
        :url => endpoint,
      }.merge(connection_options)

      @conn = Faraday::Connection.new(options) do |c|
        c.request :url_encoded
        c.token_auth self.auth_token
        c.use FaradayMiddleware::ParseJson
        c.use FaradayMiddleware::RaiseHttpException
        c.adapter(adapter)
      end

    end

    # checks correct client configuration
    def check_configuration
      case api_version
      when 1
        raise Taxjar::BadConfiguration, "Configuration error - API v1 does not support API tiers" unless api_tier.nil?
      when 2
        raise Taxjar::BadConfiguration, "Configuration error - API tier #{api_tier} is invalid" unless ['standard','enhanced'].include?(api_tier)
      end
    end

    # checks whether the requested method is available for the current configuration
    def check_availability(method_api_version: 1, method_api_tier: nil)
      raise Taxjar::NotAvailable, "Method not available for API v#{api_version}" if (method_api_version != api_version)
      raise Taxjar::NotAvailable, "Method not available for #{api_tier} API tier" if (method_api_tier != api_tier)
    end

    # returns path for TaxJar API endpoint
    #
    # examples:
    # API v1: /v1/sales_tax
    # API v2: /v2/enhanced/transactions/orders/123
    def api_path(*args)
      "/v#{api_version}/#{args.unshift(api_tier).compact.join('/')}"
    end
  end
end
