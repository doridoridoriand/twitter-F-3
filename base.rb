require 'active_record'
require 'yaml'
require 'unicorn'
require 'open-uri'
require 'json'
require 'bcrypt'

# load Service
$: << File.expand_path(File.join(__FILE__, '..', 'service'))

db_config = YAML.load_file(File.expand_path(File.join(__FILE__, '..', '..', 'config', 'database.yml')))

ActiveRecord::Base.establish_connection(db_config['db']['production'])

module Base
end
