class OpenaiService < ApplicationService
    include HTTParty
    base_uri 'https://api.openai.com/v1/images'
    def initialize(api_key)
      @api_key = api_key
    end
    def generate_image(prompt)
      body = {
        "model": "dall-e-2",
        "prompt": prompt,
        "size": "256x256",
        "quality": "standard",
        "n": 1
      }		
      response = self.class.post("/generations", headers: headers, body: body.to_json)
      JSON.parse(response.body)
    end
    private
    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@api_key}"
      }
    end
  end