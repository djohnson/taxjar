module Taxjar
  # Custom error class for rescuing from all Taxjar errors
  class Error < StandardError; end

  # Raised when Taxjar returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Taxjar returns the HTTP status code 401
  class NotAuthorized < Error; end

  # Raised when Taxjar returns the HTTP status code 403
  class Forbidden < Error; end

  # Raised when Taxjar returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Taxjar returns the HTTP status code 405
  class MethodNotAllowed < Error; end

  # Raised when Taxjar returns the HTTP status code 406
  class NotAcceptable < Error; end

  # Raised when Taxjar returns the HTTP status code 410
  class Gone < Error; end

  # Raised when Taxjar returns the HTTP status code 422
  class UnprocessableEntity < Error; end

  # Raised when Taxjar returns the HTTP status code 429
  class TooManyRequests < Error; end

  # Raised when Taxjar returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Taxjar returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when Taxjar returns the HTTP status code 504
  class GatewayTimeout < Error; end

  # Raised when the method is not available in the configured API version or tier
  class NotAvailable < Error; end

  # Raised when Taxjar configuration is invalid
  class BadConfiguration < Error; end
end
