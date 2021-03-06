class RouterFollow < Sinatra::Base

  post '/follow' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    hash = {}
    hash['uuid'] = authorized_user_uuid
    hash['target_uuid'] = ServiceUser.find_by_username(posted_data['user_id']).first.uuid
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
    hash['target_uuid'] = ServiceUser.find_by_username(posted_data['user_id']).first.uuid
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

  # 突貫で作ったため、これは機能として不完全。使用禁止
  get '/:user_id/already_follow?' do
    if ServiceUser.find_by_username(params[:user_id]).first
      content_type :json, charset: 'utf-8'
      success_response
    else
      content_type :json, charset: 'utf-8'
      fail_response
    end
  end

  get '/:user_id/following' do
    users_which_now_following = ServiceFollowing.show_uuids(ServiceUser.find_by_username(params[:user_id]).first.uuid)
    content_type :json, charset: 'utf-8'
    ServiceUser.find_by_uuid(users_which_now_following)
               .map{|entry| entry.user_detail}
               .to_json(root: false)
  end

  get '/:user_id/followers' do
    users_which_now_follower = ServiceFollower.show_uuids(ServiceUser.find_by_username(params[:user_id]).first.uuid)
    content_type :json, charset: 'utf-8'
    ServiceUser.find_by_uuid(users_which_now_follower)
               .map{|entry| entry.user_detail}
               .to_json(root: false)
  end
end
