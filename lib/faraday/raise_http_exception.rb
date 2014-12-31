require 'faraday'

module FaradayMiddleware

  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise Taxjar::BadRequest, error_message_400(response)
        when 401
          raise Taxjar::NotAuthorized, error_message_400(response)
        when 404
          raise Taxjar::NotFound, error_message_400(response)
        when 500
          raise Taxjar::InternalServerError, error_message_500(response, "Something is technically wrong.")
        when 504
          raise Taxjar::GatewayTimeout, error_message_500(response, "504 Gateway Time-out")
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{error_body(response[:body])}"
    end

    def error_body(body)

      body = ::JSON.parse(body) if not body.nil? and not body.empty? and body.kind_of?(String)

      if body.nil?
        nil
      elsif body['meta'] and body['meta']['error_message'] and not body['meta']['error_message'].empty?
        ": #{body['meta']['error_message']}"
      elsif body['error_message'] and not body['error_message'].empty?
        ": #{body['error_type']}: #{body['error_message']}"
      end
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end
