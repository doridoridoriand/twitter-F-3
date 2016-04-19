#!/usr/bin/env ruby
require 'bundler'
Bundler.require

$: << File.expand_path(File.join(__FILE__, '..'))
require 'application'

$: << File.expand_path(File.join(__FILE__, '..', 'router'))
require 'router_follow'
require 'router_register'
require 'router_login'
require 'router_logout'
require 'router_search'
require 'router_tweet'
require 'router_user'
require 'router_like'

class ApiFront < Sinatra::Base
  configure do
    set :environment, :production
    set :port, 3000
  end

  use RouterFollow
  use RouterRegister
  use RouterLogin
  use RouterLogout
  use RouterSearch
  use RouterTweet
  use RouterUser
  use RouterLike

end

run ApiFront
