# フォローフォロワーに関してDBを統一したため、このクラスはFollowingを継承している
class ServiceFollower < Following

  def self.show_uuids(params)
    self.show(params).map {|entry| entry.uuid}
  end

  def self.show(params)
    Following.where(target_uuid: params)
  end
end
