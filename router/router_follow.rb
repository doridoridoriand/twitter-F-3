class RouterFollow < Sinatra::Base

  post '/follow' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    hash = {}
    hash['uuid'] = authorized_user_uuid
    hash['target_uuid'] = posted_data['token']
    ServiceFollower.create(hash)
  end

  post '/unfollow' do
  end

  get '/following' do
  end

  get '/followers' do
  end
end
