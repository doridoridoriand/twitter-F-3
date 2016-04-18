class RouterUser < Sinatra::Base

  get '/check_header' do
    authorized_user_area!
    authorized_user_uuid
  end

  post '/check_user_id' do
    posted_data = JSON.parse request.body.read
    if ServiceUser.duplicate(posted_data['user_id'])
      content_type :json, charset: 'utf-8'
      USER_ID_ALREADY_IN_USE.error_response
    else
      content_type :json, charset: 'utf-8'
      USER_ID_CAN_GET.error_response
    end
  end

  post '/user_detail' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    if posted_data['token']
      content_type :json, charset: 'utf-8'
      ServiceUser.find_by_token(posted_data['token']).first.user_detail.to_json(root: false)
    else
      content_type :json, charset: 'utf-8'
      ServiceUser.find_by_username(posted_data['user_id']).first.user_detail.to_json(root: false)
    end
  end

  get '/token_error' do
    content_type :json, charset: 'utf-8'
    TOKEN_BROKEN.error_response
  end
end
