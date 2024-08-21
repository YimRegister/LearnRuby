class ApplicationController < ActionController::Base
    # before anything else, sets current user if there is one logged in
    before_action :set_current_user
    
    def set_current_user
            
        if session[:user_id]
            Current.user = User.find(session[:user_id])
        end
    end

    def require_user_logged_in!
        redirect_to log_in_path, alert: "User must be logged in." if Current.user.nil?

    end

end
