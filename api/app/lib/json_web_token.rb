class JsonWebToken
  EXPIRED_TIME = 24.hours.from_now

  class << self
    def encode(payload, exp = EXPIRED_TIME)
      payload[:exp] = exp.to_i
      JWT.encode payload, Api::Application.credentials.secret_key_base
    end

    def decode(token)
      body = JWT.decode(token, Api::Application.credentials.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::DecodeError => e
      raise ErrorHandler::DecodeTokenError, e.message
    end
  end
end
