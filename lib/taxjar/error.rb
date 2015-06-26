module Taxjar
  # Custom error class for rescuing from all Taxjar errors
  class Error < StandardError; end

  # Raised when Taxjar returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Taxjar returns the HTTP status code 401
  class NotAuthorized < Error; end

  # Raised when Taxjar returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Taxjar returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when the method is not available in the configured API version or tier
  class NotAvailable < Error; end
end
