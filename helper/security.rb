module Security
  def encrypt_password(password)
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  # @param none
  # @return string
  # 該当ユーザーがいなかった場合はfalse
  def is_authorized_user?
    begin
      user_data = ServiceUserTokens.find_by_token(token_from_client)
      result_data = user_data.uuid
    rescue => error
      result_data = false
    end
    result_data
  end

  def authorized_user_uuid
    user_data = ServiceUserTokens.find_by_token(token_from_client)
    user_data.uuid
  end

  private

  def token_from_client
    data = request.env.select { |k, v| k.start_with?('HTTP_WWW_AU')}
    data.values.split(' ').to_a.flatten.first.split(' ').last
  end
end
