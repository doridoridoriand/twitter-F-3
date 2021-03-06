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
    content_type :json, charset: 'utf-8'
    authorized_user_uuid.to_user_defined_tl
                        .to_tl(sort_params['from'], sort_params['to'])
                        .to_json(root: false)
  end

  # 別途の差分取得API
  post '/latest' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    content_type :json, charset: 'utf-8'
    entry_data = ServiceItem.find_by_uuid_hex(posted_data)
    latest_params = {}
    latest_params['uuid'] = authorized_user_uuid
    latest_params['from'] = entry_data.created_at
    latest_params['to']   = Time.now
    content_type :json, charset: 'utf-8'
    latest_params.to_latest_user_defined_tl.to_json(root: false)
  end

  # 別途の差分取得API
  post '/past' do
  end

  post '/tweet' do
    authorized_user_area!
    posted_data = JSON.parse request.body.read
    if posted_data["tweet"].less_than_140?
      params['uuid']      = authorized_user_uuid
      params['content']   = posted_data["tweet"]
      params['entry_hex'] = ServiceItem.create(params)
      if posted_data["tweet"].is_reply?
        # 通知を表示させる対象のuuid
        if ServiceUser.exist?(posted_data['tweet'].to_user_id)
          target_user_uuid = ServiceUser.find_by_username(posted_data["tweet"].to_user_id).first.uuid
        end
        # !!!! 他のメソッドとの互換性のために変数を状態を大きく変えている。注意 !!!!
        # !!!! ServiceItemがエントリーを記録するまでServiceNotificationを走らせてはいけない !!!!
        # !!!! 時間あったらリファクタリングしたい。。。こんな汚いコードつらい(影響範囲掴めてないのでとりあえずこのまま) !!!!
        params['entry_uuid']    = params['uuid']
        params['uuid']          = target_user_uuid
        params['attacker_uuid'] = params['entry_uuid']
        params['reply_flag']    = 1
        ServiceNotification.create(params)
      end
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
