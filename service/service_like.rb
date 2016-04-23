class ServiceLike < Likes

  # 重複していたらtrue
  # @param hash
  # @return boolean
  def self.duplicate(params)
    if params['unliker_uuid']
      params['liker_uuid'] = params['unliker_uuid']
    end
    if Likes.where(liker_uuid: params['liker_uuid'],
                   owner_uuid: params['owner_uuid'],
                   entry_hex:  params['entry_hex']).first
      true
    else
      false
    end
  end

  def self.exist?(params)
    self.duplicate(params)
  end

  def self.create(params)
    new_like = Likes.new(liker_uuid: params['liker_uuid'],
                         owner_uuid: params['owner_uuid'],
                         entry_hex:  params['entry_hex'])
    new_like.save
  end

  def self.increment(params)
    entry = Items.where(uuid: params['owner_uuid'],
                        hex:  params['entry_hex']).first
    entry.like_count += 1
    entry.save
  end

  def self.decrement(params)
    entry = Items.where(uuid: params['owner_uuid'],
                        hex:  params['entry_hex']).first
    entry.like_count -= 1
    entry.save
  end

  def self.delete(params)
    params['liker_uuid'] = params['unliker_uuid']
    target_like = Likes.where(liker_uuid: params['liker_uuid'],
                              owner_uuid: params['owner_uuid'],
                              entry_hex:  params['entry_hex']).first
    target_like.destroy
  end
end
