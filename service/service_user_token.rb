class ServiceUserTokens < UserToken

  # User Tokenに関してはその性質上、作成と削除しか叩けない

  def self.find_by_token(params)
    UserToken.where(token: params).first
  end

  def self.exist?(params)
    if UserToken.where(token: params).first
      params
    end
  end

  def self.create(params)
    user_token = SecureRandom.hex(10)
    UserToken.create(uuid:  params,
                     token: user_token)
    user_token
  end

  def self.delete(params)
    mached_token = UserToken.where(token: params).first
    mached_token.destroy
  end
end
