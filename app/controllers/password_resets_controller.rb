class PasswordResetsController < ApplicationController
    def new

    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            #send email
            PasswordMailer.with(user: @user).reset.deliver_later


            redirect_to root_path, notice: "If a user with that email was found, an email verification code will be sent shortly."
      
        else
            redirect_to root_path, notice: "If a user with that email was found, an email verification code will be sent shortly."
      
        end
    end

        def edit
            @user = User.find_signed!(params[:token], purpose: "password_reset")
        rescue ActiveSupport::MessageVerifier::InvalidSignature
            redirect_to password_reset_path, alert: "Your token has expired."
        end

        def update
            @user = User.find_signed!(params[:token], purpose: "password_reset")
            if @user.update(password_params)
                redirect_to log_in_path, notice: "Your password was reset."
            else
                render :edit

            end
        end

        private
        def password_params
            params.require(:user).permit(:password,:password_confirmation)
        end

end
