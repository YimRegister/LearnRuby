class AiplusController < ApplicationController
  require 'open-uri'
    def index
      # renders views/aiplus/index.html.erb

      # if they haven't input anything yet
      # TODO: better error checking here
      if params[:noun].blank?
        #fill in the result image with the placeholder image
        @result = 'yourimage.png'
        
      # otherwise, process their prompt
      else
        prompt = params[:noun] +' ' +params[:descriptor]+ ' ' + params[:verb]
      
        # TODO: this needs to be initialized somewhere else, not every time 
        client = OpenAI::Client.new(
        access_token: Rails.application.credentials.dig(:openai, :api_key_secret),
        log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
        )
      
        # error catching block
        begin
          # try to generate the image from the prompt given
          @image_data = client.images.generate(parameters: { prompt:  prompt, size: "256x256" })
          
          # however, the API may return an error, sometimes for content moderation
        rescue Faraday::Error => e
          # TODO: make sure this helper works
          handle_error()

        else #if no error
          #puts @image_data.dig("data", 0, "url")
  
          # Process @image_data and display the image in the view
          if @image_data && @image_data["data"].is_a?(Array) && @image_data["data"].any?
            image_url = @image_data["data"].first()["url"]
            @prompt = prompt
            @result = image_url
            
            render :index, status: 422
          end
        end
      
    
    end
  end


def new
    @image = Image.new
end


def save_image
  if params[:url] == "yourimage.png" 
    
    @result ='yourimage.png'
    flash.now[:alert] = "Image not saved, please generate an AI image."
    render :index 
  else
    @image = Image.new(title: params[:title],url: params[:url],user_id: session[:user_id]) 
    require 'open-uri'
    require 'uri'
    @image.save!
    File.open('app/assets/images/'+ "#{@image.id}" +'.png', 'wb') do |fo|
        fo.write URI.open(params[:url]).read
        
      end 
  
      @image.url ="#{@image.id}"+".png"

      #absolutely initialize somewhere else, not every time!!!
      credentials = Aws::Credentials.new(
        Rails.application.credentials.dig(:aws, :access_key_id), Rails.application.credentials.dig(:aws, :secret_access_key)
        )
    s3 = Aws::S3::Resource.new(region:'us-east-1',credentials:credentials)
    obj = s3.bucket("ai-images-promptlab").object(@image.url) # make sure your filename has an extension (.jpg for example)

    File.open(open('app/assets/images/'+ "#{@image.id}" +'.png'), 'rb') do |file|
      obj.put(body: file)
    end
    
    #workaround temp image saved to local, pushed to bucket, then deleted
    if @image.save
        File.delete('app/assets/images/'+ "#{@image.id}" +'.png')
        #session[:user_id] = @user.id
        redirect_to dashboard_path, notice: "Saved your image: \"" + "#{params[:title]}" +"\""
    
      
      end
  
  end
  
  

  
end

def image_params
  params.require(:image).permit(:id, :title, :url, :user_id )
end


def handle_error
  flash.now[:alert] =  "Oops! Your prompt \"" + "#{prompt}" + "\" includes a restricted word. Try again."
          # TODO: log the prompts that go against rules in an Errors model
          
          params[:noun]= nil # why do I do this? to reset the image on reload? bad logic
          @prompt = nil # reset the prompt
          @result = 'yourimage.png' # reset the image
          render :index, status: 422 #give status so turbo works, re-render index to start over but with flash alert

end






end
    