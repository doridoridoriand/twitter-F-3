class RouterTweet < Sinatra::Base

  # APIのルートにGETでアクセスするとタイムライン一覧を取得するという仕様なのでそれに従う
  get '/' do
    authorized_user_area!
    sort_params = {}
    unless params['amounts'] && params['page']
      sort_params['from'] = 0
      sort_params['to']   = 100
    else
      amounts = params['amounts'].to_i
      page    = params['page'].to_i
      sort_params['from'] = page == 0 ? 0 : amounts * page + 1
      sort_params['to']   = amounts * page + amounts
    end
    user_uuids_which_following = ServiceFollowing.find_by_uuid(authorized_user_uuid)
    user_uuids_which_following << authorized_user_uuid
    entries = ServiceItem.show_with_uuid(user_uuids_which_following)
    content_type :json, charset: 'utf-8'
    entries.to_tl(sort_params['from'], sort_params['to']).to_json(root: false)
  end

  post '/tweet' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    if posted_data["tweet"].less_than_140?
      params['uuid'] = authorized_user_uuid
      params['content'] = posted_data["tweet"]
      ServiceItem.create(params)
      content_type :json, charset: 'utf-8'
      success_response
    else
      content_type :json, charset: 'utf-8'
      CONTENT_OVER_140.error_response
    end
  end

  get '/:user_id/with_recipes' do
    if ServiceUser.exist?(params[:user_id])
      content_type :json, charset: 'utf-8'
      ServiceItem.find_by_username(params[:user_id]).to_json(root: false)
    else
      content_type :json, charset: 'utf-8'
      USER_NOT_FOUND.error_response
    end
  end

  get '/:uuid/:hex' do
    data = ServiceItem.find_by_uuid_hex(params)
    content_type :json, charset: 'utf-8'
    data.to_json(root: false)
  end
end
