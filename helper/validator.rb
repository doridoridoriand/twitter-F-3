$: << File.expand_path(File.join(__FILE__, '..', 'lib')) 
require 'constants'

include Constants

module Validator

  # @param  contents
  # @return contents or Raise Error
  def is_140?
    unless self.length.to_i <= 140
      raise 'ContentsOver140'
    else
      self
    end
  end

  def has_problems?
    false
  end

end
