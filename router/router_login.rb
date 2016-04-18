class RouterLogin < Sinatra::Base

  post '/login' do
    posted_data = JSON.parse request.body.read
    if ServiceUser.exist?(posted_data['name']) && ServiceUser.authenticate(posted_data['name'], posted_data['password'])
      user_info  = ServiceUser.find_by_username(posted_data['name']).first
      user_token = ServiceUserTokens.create(user_info.uuid)
      data = {}
      data[:screen_name] = user_info.screen_name
      data[:token]       = user_token
      content_type :json, charset: 'utf-8'
      data.post_response
    else
      content_type :json, charset: 'utf-8'
      LOGIN_INFORMATION_HAS_WRONG.error_response
    end
  end
end
