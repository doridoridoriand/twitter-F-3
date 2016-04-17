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

end
