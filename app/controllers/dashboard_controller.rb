class DashboardController < ApplicationController
    before_action :require_user_logged_in!
    def index
        
   

        @images = Image.where(:user_id => session[:user_id]).all
        puts session[:user_id]
    end

    def destroy
        
        @image = Image.find(params[:id])
        @image.destroy
        flash[:notice] = "Image successfully deleted"
        redirect_to(:action => 'index')
    end
    
      
end
