class RouterUser < Sinatra::Base

  post '/check_user_id' do
    posted_data = JSON.parse request.body.read
    content_type :text, charset: 'utf-8'
    if ServiceUser.duplicate(posted_data['name'])
      content_type :json, charset: 'utf-8'
      {"error": USER_ID_ALREADY_IN_USE}.to_json(root: false)
    else
      content_type :json, charset: 'utf-8'
      {"error": USER_ID_CAN_GET}.to_json(root: false)
    end
  end
end
