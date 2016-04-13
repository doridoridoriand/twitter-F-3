class RouterUser < Sinatra::Base

  get '/check_header' do
    if is_authorized_user?
      authorized_user_uuid
    end
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
end
