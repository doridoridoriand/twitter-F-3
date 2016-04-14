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
      ServiceItem.show(number_of_items).to_json(root: false)
  end

  post '/tweet' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    params['uuid'] = authorized_user_uuid
    params['content'] = posted_data["text"]
    ServiceItem.create(params)
  end

  get '/tweet/:tweet_id' do
  end
end
