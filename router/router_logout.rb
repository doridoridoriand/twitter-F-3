class RouterLogout < Sinatra::Base
  post '/logout' do
    authorized_user_area!
    if ServiceUserTokens.exist?(authorized_user_token)
      ServiceUserTokens.delete(authorized_user_token)
      content_type :json, charset: 'utf-8'
      success_response
    else
      content_type :json, charset: 'utf-8'
      TOKEN_BROKEN.error_response
    end
  end
end
