class RouterLike < Sinatra::Base

  post '/like' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    posted_data['liker_uuid'] = authorized_user_uuid
    if ServiceItem.exist?(posted_data)
      unless ServiceLike.duplicate(posted_data)
        ServiceLike.increment(posted_data)
        ServiceLike.create(posted_data)
        # 通知用メソッドに渡すhash
        notify_data = {}
        notify_data['uuid']          = posted_data['owner_uuid']
        notify_data['entry_uuid']    = posted_data['owner_uuid']
        notify_data['entry_hex']     = posted_data['entry_hex']
        notify_data['attacker_uuid'] = authorized_user_uuid
        notify_data['like_flag']     = 1
        ServiceNotification.create(notify_data)
        content_type :json, charset: 'utf-8'
        success_response
      else
        content_type :json, charset: 'utf-8'
        TWEET_ALREADY_LIKED.error_response
      end
    else
      content_type :json, charset: 'uft-8'
      TWEET_NOT_FOUND_ERROR.error_response
    end
  end

  post '/unlike' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    posted_data['unliker_uuid'] = authorized_user_uuid
    if ServiceLike.exist?(posted_data)
      ServiceLike.decrement(posted_data)
      ServiceLike.delete(posted_data)
      hash = {}
      hash['entry_uuid']    = posted_data['owner_uuid']
      hash['entry_hex']     = posted_data['entry_hex']
      hash['attacker_uuid'] = authorized_user_uuid
      ServiceNotification.delete(hash)
      content_type :json, charset: 'utf-8'
      success_response
    else
      content_type :json, charset: 'utf-8'
      TWEET_NOT_LIKE_YET.error_response
    end
  end

  get '/like' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    posted_data['uuid'] = authorized_user_uuid
  end
end
