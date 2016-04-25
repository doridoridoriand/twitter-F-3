module Timeline
  def to_tl(from, to)
    hash = Hash.new {|h, k| h[k] = {}}
    self[from..to].each_with_index do |entry, i|
      user_info                  = ServiceUser.find_by_uuid(entry.uuid).first
      hash[i][:user_icon]        = 'https://s3-ap-northeast-1.amazonaws.com/teamf-mofmofneko/VqP3mcWa.png'
      hash[i][:user_id]          = user_info.user_id
      hash[i][:screen_name]      = user_info.screen_name
      hash[i][:uuid]             = user_info.uuid
      hash[i][:hex]              = entry.hex
      hash[i][:content]          = entry.content
      hash[i][:tweet_detail_url] = "#{ROOT_URL}/#{entry.uuid}/#{entry.hex}"
      hash[i][:like_count]       = entry.like_count
      hash[i][:retweet_count]    = entry.retweet_count
      hash[i][:created_at]       = entry.created_at
    end
    hash.values
  end

  def to_notify_tl
    hash = Hash.new {|h, k| h[k] = {}}
    self.each_with_index do |entry, i|
      entry_identify = {}
      entry_identify['uuid'] = entry.entry_uuid
      entry_identify['hex']  = entry.entry_hex
      entry_info = ServiceItem.find_by_uuid_hex(entry_identify)
      hash[i][:like_flag] = entry.like_flag
      hash[i][:retweet_flag] = entry.retweet_flag
      hash[i][:reply_flag] = entry.reply_flag
      hash[i][:servant] = ServiceUser.find_by_uuid(entry.attacker_uuid).first.user_detail
      hash[i][:content] = entry_info
    end
    hash.values
  end

  def to_user_defined_tl
    user_uuids_which_following = ServiceFollowing.find_by_uuid(self)
    user_uuids_which_following << self
    ServiceItem.show_with_uuid(user_uuids_which_following)
  end

  # ツイート内容の先頭が@で始まっており、かつそれ以降の文字列がuser_id(バリデーションに準拠する形だったときのみ)trueを返す
  # @return boolean
  def is_reply?
    matcher = Regexp.new(ALPHABET_INTEGER_MATCHER)
    if self.slice(0) == '@' && self.to_user_id =~ matcher
      true
    else
      false
    end
  end

  def to_user_id
    self.split(' ').first.delete('@')
  end
end
