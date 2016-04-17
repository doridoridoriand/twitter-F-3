class RouterFollow < Sinatra::Base

  post '/follow' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    hash = {}
    hash['uuid'] = authorized_user_uuid
    hash['target_uuid'] = ServiceUserTokens.find_by_token(posted_data["target_user_token"]).uuid
    # 既にフォローしていないか重複チェック
    if ServiceFollowing.is_already_followed?(hash)
      content_type :json, charset: 'utf-8'
      TARGET_USER_ALREADY_FOLLOWED.error_response
    else
      ServiceFollowing.create(hash)
      content_type :json, charset: 'utf-8'
      success_response
    end
  end

  post '/unfollow' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    hash = {}
    hash['uuid'] = authorized_user_uuid
    hash['target_uuid'] = ServiceUserTokens.find_by_token(posted_data["target_user_token"]).uuid
    # そもそもフォローしていない場合の対処
    unless ServiceFollowing.is_not_follow_yet?(hash)
      ServiceFollowing.delete(hash)
      content_type :json, charset: 'utf-8'
      success_response
    else
      content_type :json, charset: 'utf-8'
      TARGET_USER_NOT_FOLLOW_YET.error_response
    end
  end

  get '/following' do
    authorized_user_area!
  end

  get '/followers' do
    authorized_user_area!
  end
end
