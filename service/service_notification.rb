class ServiceNotification < Notification

  # replyに関してはentry_uuid
  def self.create(params)
    notice = Notification.new(uuid: params['uuid'] || '00000000-0000-0000-0000-000000000000')
    notice.entry_uuid   = params['entry_uuid']
    notice.entry_hex    = params['entry_hex']
    notice.like_flag    = params['like_flag'] || 0
    notice.retweet_flag = params['retweet_flag'] || 0
    notice.reply_flag   = params['reply_flag'] || 0
    notice.save
  end

  def self.delete(params)
  end
end
