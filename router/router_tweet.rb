class RouterTweet < Sinatra::Base

  # APIのルートにGETでアクセスするとタイムライン一覧を取得するという仕様なのでそれに従う
  get '/' do
    "teamF_twitterAPI"
  end

  post '/tweet' do
  end

  get '/tweet/:tweet_id' do
  end
end
