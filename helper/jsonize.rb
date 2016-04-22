module Jsonize
  def post_response
    {
      "result":true,
      "data": {
        "token": self[:token],
        "screen_name": self[:screen_name]
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
      'screen_name': self.screen_name,
      'user_icon': "https://s3-ap-northeast-1.amazonaws.com/teamf-mofmofneko/VqP3mcWa.png"
    }
  end
end
