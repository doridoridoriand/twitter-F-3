class RouterRegister < Sinatra::Base

  post '/register' do
    posted_data = JSON.parse request.body.read
    if posted_data.has_problems?

      content_type :json, charset: 'utf-8'
      WRONG_FORMAT.error_response
    else
      unless ServiceUser.duplicate(posted_data['name'])
        user_token = ServiceUserTokens.create(ServiceUser.create(posted_data))
        data = {}
        data[:screen_name] = posted_data['screenName']
        data[:token]       = user_token
        content_type :json, charset: 'utf-8'
        data.post_response
      else
        content_type :json, charset: 'utf-8'
        USER_ID_ALREADY_IN_USE.error_response
      end
    end
  end
end
