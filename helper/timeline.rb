module Timeline
  def to_tl
    hash = Hash.new {|h, k| h[k] = {}}
    self.each_with_index do |entry, i|
      user_info                  = ServiceUser.find_by_uuid(entry.uuid).first
      hash[i][:user_id]          = user_info.user_id
      hash[i][:screen_name]      = user_info.screen_name
      hash[i][:content]          = entry.content
      hash[i][:tweet_detail_url] = "#{ROOT_URL}/#{entry.uuid}/#{entry.hex}"
      hash[i][:created_at]       = entry.created_at
    end
    hash.values
  end
end
