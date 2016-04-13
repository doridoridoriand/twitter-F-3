class RouterTweet < Sinatra::Base

  # APIのルートにGETでアクセスするとタイムライン一覧を取得するという仕様なのでそれに従う
  get '/' do
    "teamF_twitterAPI"
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
