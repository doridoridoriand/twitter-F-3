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
end
