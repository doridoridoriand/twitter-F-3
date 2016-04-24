class RouterRecommend < Sinatra::Base

  get '/recommend_users' do
    ServiceRecommendUser.all.map{|entry| entry.user_detail}.to_json(root: false)
  end
end
