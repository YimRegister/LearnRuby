class PasswordsController < ApplicationController
   #make sure user is logged in
   before_action :require_user_logged_in!
   
    def edit
        

    end


    def update
        if Current.user.update(password_params)
            redirect_to dashboard_path, notice: "Password successfully updated."
        else
            render :edit
        end
    end

    private
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
