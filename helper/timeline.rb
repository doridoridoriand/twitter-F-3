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
      hash[i][:tweet_detail_url] = "#{ROOT_URL}/#{entry.uuid}/#{entry.hex}",
      hash[i][:like_count]       = entry.like_count,
      hash[i][:retweet_count]    = entry.retweet_count,
      hash[i][:created_at]       = entry.created_at
    end
    hash.values
  end
end
