class RouterUser < Sinatra::Base

  get '/check_header' do
    authorized_user_area!
    authorized_user_uuid
  end

  post '/check_user_id' do
    posted_data = JSON.parse request.body.read
    if ServiceUser.duplicate(posted_data['name'])
      content_type :json, charset: 'utf-8'
      USER_ID_ALREADY_IN_USE.error_response
    else
      content_type :json, charset: 'utf-8'
      USER_ID_CAN_GET.error_response
    end
  end

  get '/token_error' do
    content_type :json, charset: 'utf-8'
    TOKEN_BROKEN.error_response
  end
end
