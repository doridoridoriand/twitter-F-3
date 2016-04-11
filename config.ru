#!/usr/bin/env ruby
require 'bundler'
Bundler.require

$: << File.expand_path(File.join(__FILE__, '..', 'router'))
require 'router_follow'
require 'router_register'
require 'router_search'
require 'router_tweet'
require 'router_user'

class ApiFront < Sinatra::Base
  configure do
    set :environment, :production
    set :port, 3000
  end

  use RouterFollow
  use RouterRegister
  use RouterSearch
  use RouterTweet
  use RouterUser

end

run ApiFront
