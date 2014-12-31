require_relative "taxjar/version"
require_relative "taxjar/error"
require_relative "taxjar/configuration"
require_relative "taxjar/client"

module Taxjar
  extend Configuration

  def self.client(options={})
    Taxjar::Client.new(options)
  end

  # Delegate to Taxjar::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Taxjar::Client
  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end
