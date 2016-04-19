class ServiceFollowing < Following

  def self.create(params)
    Following.create(uuid: params['uuid'],
                     target_uuid: params['target_uuid'])
  end

  def self.delete(params)
    target = Following.where(uuid: params['uuid'],
                             target_uuid: params['target_uuid']).first
    target.destroy
  end

  def self.show_uuids(params)
    self.show(params).map {|entry| entry.target_uuid}
  end

  def self.show(params)
    Following.where(uuid: params)
  end

  # @param string
  # @return array
  def self.find_by_uuid(params)
    Following.where(uuid: params).map {|data| data.target_uuid}
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

  def self.is_not_follow_yet?(params)
    !ServiceFollowing.is_already_followed?(params)
  end
end
