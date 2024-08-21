class AiplusController < ApplicationController
  require 'open-uri'
    def index
      if params[:noun].blank?
            
        @result = 'yourimage.png'
        
    
      else
        prompt = params[:noun] +' ' +params[:descriptor]+ ' ' + params[:verb]
      

      client = OpenAI::Client.new(
      access_token: Rails.application.credentials.dig(:openai, :api_key_secret),
      log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
      )
      @image_data = client.images.generate(parameters: { prompt:  prompt, size: "256x256" })
      puts @image_data.dig("data", 0, "url")
 
      # Process @image_data and display the image in the view
      if @image_data && @image_data["data"].is_a?(Array) && @image_data["data"].any?
        image_url = @image_data["data"].first()["url"]
        @prompt = prompt
        @result = image_url
        render :index, status: 422
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

    puts "I'M HERE!"
     
    @image = Image.new(title: params[:title],url: params[:url],user_id: session[:user_id])
    
    require 'open-uri'
    require 'uri'
    @image.save!
    File.open('app/assets/images/'+ "#{@image.id}" +'.png', 'wb') do |fo|
        fo.write URI.open(params[:url]).read
        
      end 
  
      @image.url ="#{@image.id}"+".png"
    
    
    if @image.save
      
        #session[:user_id] = @user.id
        redirect_to dashboard_path, notice: "Saved your image: \"" + "#{params[:title]}" +"\""
    
      
      end
  
  end
  
  

  
end

def image_params
  params.require(:image).permit(:id, :title, :url, :user_id )
end


end
    