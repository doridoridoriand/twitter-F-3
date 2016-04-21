module Validator

  # @param  contents
  # @return boolean
  def less_than_140?
    unless self.length.to_i <= 140
      false
    else
      true
    end
  end

  def has_problems?
    false
  end

  def only_character
    match = Regexp.new(/^[a-zA-Z0-9]+$/)
    result = match =~ self
    if result === 0
      true
    elsif result = nil
      false
    end
  end

end
