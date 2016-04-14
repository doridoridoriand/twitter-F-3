class ServiceFollower < Follower

  def self.create(params)
    if ServiceUser.exist?(params)
      Follower.create(uuid:        params['uuid'],
                      target_uuid: params['target_uuid'])
    end
  end

  def self.delete(params)
    if ServiceUser.exist?(params)
      Follower.delete(uuid:        params['uuid'],
                      target_uuid: params['target_uuid'])
    end
  end
end
