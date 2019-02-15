class AuthorizeApiRequest
  def initialize headers
    @headers = headers
  end

  def call
    user
  end

  private

  def user
    return unless http_auth_token
    User.find_by id: http_auth_token["id"]
  end

  def http_auth_token
    JsonWebToken.decode @headers["authorization"] if @headers["authorization"].present?
  end
end
