class RouterNotification < Sinatra::Base

  get '/notification' do
    authorized_user_area!
    content_type :json, charset: 'utf-8'
    ServiceNotification.find_by_uuid(authorized_user_uuid).to_notify_tl.to_json(root: false)
  end
end

