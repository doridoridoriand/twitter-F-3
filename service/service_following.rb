class ServiceFollowing < Following

  def self.create(params)
    Following.create(uuid: params['uuid'],
                     target_uuid: params['target_uuid'])
  end

  def self.delete(params)
    Following.delete(uuid: params['uuid'],
                     target_uuid: params['target_uuid'])
  end

  def self.show(params)
  end

  def self.find_by_uuid(params)
    Following.where(uuid: params['uuid'])
  end

  # @param hash
  # @return boolean
  def self.is_already_followed?(params)
    if Following.where(uuid: params['uuid'],
                       target_uuid: params['target_uuid']).first
      true
    else
      false
    end
  end
end
