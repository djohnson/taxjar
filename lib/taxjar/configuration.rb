require "faraday"

module Taxjar
  module Configuration
    VALID_CONFIG_KEYS = [
      :adapter,
      :auth_token,
      :endpoint,
      :format,
      :proxy,
      :user_agent,
      :connection_options,
      :api_version ]

    DEFAULT_ADAPTER = Faraday.default_adapter
    DEFAULT_AUTH_TOKEN = "dae79dc5154ccabd7cb169f616d605e7"
    DEFAULT_ENDPOINT = "https://api.taxjar.com".freeze
    DEFAULT_FORMAT = :json
    DEFAULT_PROXY = nil
    DEFAULT_USER_AGENT = "Taxjar ruby Gem #{Taxjar::VERSION}".freeze

    DEFAULT_CONNECTION_OPTIONS = {}
    DEFAULT_API_VERSION = 1

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_CONFIG_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    def reset
      self.adapter    = DEFAULT_ADAPTER
      self.endpoint   = DEFAULT_ENDPOINT
      self.auth_token = DEFAULT_AUTH_TOKEN
      self.format     = DEFAULT_FORMAT
      self.proxy      = DEFAULT_PROXY
      self.user_agent = DEFAULT_USER_AGENT
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.api_version = DEFAULT_API_VERSION
    end

  end # Configuration
end
