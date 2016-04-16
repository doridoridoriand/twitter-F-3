require 'active_record'
require 'yaml'
require 'unicorn'
require 'open-uri'
require 'json'
require 'bcrypt'

# load lib
$: << File.expand_path(File.join(__FILE__, '..', 'lib'))
require 'constants'

# load model
$: << File.expand_path(File.join(__FILE__, '..', 'model'))
require 'item'
require 'user'
require 'user_token'
require 'follower'
require 'following'

# load service
$: << File.expand_path(File.join(__FILE__, '..', 'service'))
require 'service_item'
require 'service_user'
require 'service_user_token'
require 'service_follower'
require 'service_following'

# load helper
$: << File.expand_path(File.join(__FILE__, '..', 'helper'))
require 'validator'
require 'security'
require 'jsonize'
require 'timeline'

db_config = YAML.load_file(File.expand_path(File.join(__FILE__, '..', 'config', 'database.yml')))

ActiveRecord::Base.establish_connection(db_config['db']['production'])

include Constants
include Validator
include Security
include Jsonize
include Timeline

module Base
end
