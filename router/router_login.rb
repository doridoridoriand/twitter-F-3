class RouterLogin < Sinatra::Base

  post '/login' do
    posted_data = JSON.parse request.body.read
    if ServiceUser.exist?(posted_data['name']) && ServiceUser.authenticate(posted_data['name'], posted_data['password'])
      user_uuid  = ServiceUser.find_by_username(posted_data['name']).first
      user_token = ServiceUserTokens.create(user_uuid.uuid)
      content_type :json, charset: 'utf-8'
      user_token.post_response
    else
      content_type :json, charset: 'utf-8'
      {"error": LOGIN_INFORMATION_HAS_WRONG}.to_json(root: false)
    end
  end
end
