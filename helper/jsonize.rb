module Jsonize
  def post_response
    {
      "result":true,
      "data": {
        "token": self
      }
    }.to_json
  end
end
