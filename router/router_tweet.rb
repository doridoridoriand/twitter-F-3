class RouterTweet < Sinatra::Base

  # APIのルートにGETでアクセスするとタイムライン一覧を取得するという仕様なのでそれに従う
  get '/' do
    authorized_user_area!
    sort_params = {}
    authorized_user_uuid
    unless params['amounts'] && params['page']
      sort_params['from'] = 0
      sort_params['to']   = 100
    else
      content_type :json, charset: 'utf-8'
      amounts = params['amounts'].to_i
      page    = params['page'].to_i
      sort_params['from'] = page == 0 ? 0 : amounts * page + 1
      sort_params['to']   = amounts * page + amounts
    end
      content_type :json, charset: 'utf-8'
      data = ServiceItem.show_with_uuid_date(sort_params)
      data.to_tl.to_json
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

  get '/:uuid/:hex' do
    data = ServiceItem.find_by_uuid_hex(params)
    content_type :json, charset: 'utf-8'
    data.to_json(root: false)
  end
end
