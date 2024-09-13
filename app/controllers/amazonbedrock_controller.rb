class AmazonbedrockController < ApplicationController
    def index
        #render the views/amazonbedrock/index.html

    end


    def create_image
        require "aws-sdk-bedrockruntime" 
        @input = params[:input] # processes the input from the form
        credentials = Aws::Credentials.new(
      Rails.application.credentials.dig(:aws, :access_key_id), Rails.application.credentials.dig(:aws, :secret_access_key)
      )
        client = Aws::BedrockRuntime::Client.new(
        region: "us-east-1",
        credentials: credentials
        )
        accept = "application/json"
        content_type = "application/json"
        prompt = @input
        response  = client.invoke_model({
            body: JSON.generate({
                "taskType": "TEXT_IMAGE",
                "textToImageParams": {
                    "text": prompt
                },
                "imageGenerationConfig": {
                    "numberOfImages": 1,
                    "height": 512,
                    "width": 512
                }
            }), # required
            content_type: content_type,
            accept: accept,
            model_id: "amazon.titan-image-generator-v1", # required
            #trace: "ENABLED", # accepts ENABLED, DISABLED
            #guardrail_identifier: "GuardrailIdentifier",
            #guardrail_version: "GuardrailVersion",
                })

       

        response_object = JSON.parse(response.body.read, symbolize_names: true)
        
        require "base64"

        # decode64
        img_from_base64 = Base64.decode64(response_object[:images].first)
        # => "\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\xAA\x00\x00\x00\xAA\b\x06\x00\x00\x00=v\xD4\x82\x00\x00\x00IDATx\x9C\xEC\xBDi\x98%Wy\xE7\xF9;[D\xDC-3++k\xDF\xF7U\xA2T\x92J*\xAD\xA5}A`\ff\xB1\xB11\ ..."
        @result = "data:image/jpeg;base64,"+response_object[:images].first
        # cut the data where it seems to hold the filetype
        img_from_base64[0,8]
        # => "\x89PNG\r\n\x1A\n"

        # find file type
        filetype = /(png|jpg|jpeg|gif|PNG|JPG|JPEG|GIF)/.match(img_from_base64[0,16])[0]
        # name the file
        filename = "image_name"

        # write file
        file = filename << '.' << filetype
        File.open(file, 'wb') do|f|
        f.write(img_from_base64)
        end
        render :index, status: 422
        
        
        

    end


    

end
