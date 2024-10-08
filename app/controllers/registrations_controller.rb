class RegistrationsController < ApplicationController
    def new
      @user = User.new
    end

    def create
      #render plain: "Submitted!"
      #render plain: params[:user]
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Successfully created new user"
      else
        #flash[:alert] = "New User Not Created"
        render :new
      end

    end

    private
    def user_params
      params.require(:user).permit(:email, :username, :password,:password_confirmation)
    end
end