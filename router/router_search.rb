class RouterSearch < Sinatra::Base

  get '/search?q=:search_string' do
  end

  get '/all_users' do
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
    ServiceUser.show(sort_params).to_json(root: false)
  end
end
