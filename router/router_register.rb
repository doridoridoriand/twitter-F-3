class RouterRegister < Sinatra::Base

  post '/register' do
    posted_data = JSON.parse request.body.read
    if posted_data.has_problems?

      content_type :json, charset: 'utf-8'
      {"error": WRONG_FORMAT}.to_json(root: false)
    else
      unless ServiceUser.duplicate(posted_data['name'])
        user_token = ServiceUserTokens.create(ServiceUser.create(posted_data))
        content_type :json, charset: 'utf-8'
        user_token.post_response
      else
        content_type :json, charset: 'utf-8'
        {"error": USER_ID_ALREADY_IN_USE}.to_json(root: false)
      end
    end
  end
end
