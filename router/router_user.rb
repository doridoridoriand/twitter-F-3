class RouterUser < Sinatra::Base

  get '/check_header' do
    authorized_user_area!
    authorized_user_uuid
  end

  post '/check_user_id' do
    posted_data = JSON.parse request.body.read
    if ServiceUser.duplicate(posted_data['name'])
      content_type :json, charset: 'utf-8'
      {"error": USER_ID_ALREADY_IN_USE}.to_json(root: false)
    else
      content_type :json, charset: 'utf-8'
      {"error": USER_ID_CAN_GET}.to_json(root: false)
    end
  end

  get '/token_error' do
    {"error": TOKEN_BROKEN}.to_json(root: false)
  end
end
