class ServiceNotification < Notification

  # replyに関してはentry_uuid
  def self.create(params)
    notice = Notification.new(uuid: params['uuid'] || '00000000-0000-0000-0000-000000000000')
    notice.entry_uuid    = params['entry_uuid']
    notice.entry_hex     = params['entry_hex']
    notice.attacker_uuid = params['attacker_uuid']
    notice.like_flag     = params['like_flag'] || 0
    notice.retweet_flag  = params['retweet_flag'] || 0
    notice.reply_flag    = params['reply_flag'] || 0
    notice.save
  end

  def self.delete(params)
    notice = Notification.where(entry_uuid: params['entry_uuid'],
                                entry_hex: params['entry_hex'],
                                attacker_uuid: params['attacker_uuid']).first
    notice.destroy
  end

  def self.find_by_uuid(params)
    Notification.where(uuid: params).order('created_at desc')
  end
end
