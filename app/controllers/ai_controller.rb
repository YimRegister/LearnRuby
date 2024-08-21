class AiController < ApplicationController
    def index
        

        if params['prompt'].nil?
            
            @result = 'yourimage.png'
            
            render :index 

        end 
        
        if params['prompt'].present?
          prompt = params[:prompt]
        
          #Rails.application.credentials.dig(:openai, :api_key_secret)
          #OpenAI.configure do |config|
            #config.access_token = ENV['OPENAI_ACCESS_TOKEN']
            #config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID") # Optional.
         # end

        client = OpenAI::Client.new(
        access_token: Rails.application.credentials.dig(:openai, :api_key_secret),
        log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
        )

          
          @image_data = client.images.generate(parameters: { prompt:  prompt, size: "256x256" })
          puts @image_data.dig("data", 0, "url")
           
            
        end


      # Process @image_data and display the image in the view
        
        
        if @image_data && @image_data["data"].is_a?(Array) && @image_data["data"].any?
          image_url = @image_data["data"].first()["url"]
        end

        @result = image_url
        @prompt = prompt
        
    
      end
    
    end
    