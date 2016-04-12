$: << File.expand_path(File.join(__FILE__, '..', '..', 'model'))
require 'item'

def self.create(params)
  new_item = Items.new()
  new_user.save
end
