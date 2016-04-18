module Jsonize
  def post_response
    {
      "result":true,
      "data": {
        "token": self
      }
    }.to_json
  end

  def error_response
    {"error": self}.to_json(root: false)
  end

  def success_response
    {
      "result": true
    }.to_json(root: false)
  end

  def user_detail
    {
      'user_id': self.user_id,
      'screen_name': self.screen_name
    }
  end
end
