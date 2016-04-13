class ServiceUser < Users

  # 重複していた場合trueを返す
  def self.duplicate(user)
    if Users.where(user_id: user).first
      true
    end
  end

  def self.authenticate(user_id, password)
    exist_user = Users.where(user_id: user_id).first
    if exist_user && exist_user.password_hash == BCrypt::Engine.hash_secret(password, exist_user.password_hash)
      exist_user
    else
      nil
    end
  end

  def self.exist?(user)
    if Users.where(user_id: user).first
      user
    end
  end

  def self.find_by_username(username)
    Users.where(user_id: username)
  end

  # @return uuid
  def self.create(params)
    user_uuid = SecureRandom.uuid
    new_user = Users.new(user_id: params['name'],
                 uuid: user_uuid,
                 screen_name: params['screenName'],
                )
    new_user.encrypt_password(params['password'])
    new_user.save
    user_uuid
  end

  def self.update
  end

  def self.delete
  end
end
