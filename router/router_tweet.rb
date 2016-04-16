class RouterTweet < Sinatra::Base

  # APIのルートにGETでアクセスするとタイムライン一覧を取得するという仕様なのでそれに従う
  get '/' do
    number_of_items = {}
    unless params['amounts'] && params['page']
      number_of_items['from'] = 0
      number_of_items['to']   = 100
    else
      content_type :json, charset: 'utf-8'
      amounts = params['amounts'].to_i
      page    = params['page'].to_i
      number_of_items['from'] = page == 0 ? 0 : amounts * page + 1
      number_of_items['to']   = amounts * page + amounts
    end
      content_type :json, charset: 'utf-8'
      data = ServiceItem.show(number_of_items)
      data.to_tl.to_json
  end

  post '/tweet' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    if posted_data["tweet"].less_than_140?
      params['uuid'] = authorized_user_uuid
      params['content'] = posted_data["tweet"]
      ServiceItem.create(params)
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
