class SessionsController < ApplicationController
   def new
        @user = User.new
        render :new
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by_credentials(username, password)

        if @user
            login!(@user) 
            redirect_to user_url(@user)
        else
            
            @user = User.new(username: username)
        
            flash.now[:errors] = ["Invalid Credentials, please try again"]
            render :new
        end
    end

    def destroy
    if logged_in?
        logout!
    end

    flash[:messages] = ["Logged out!"]
    redirect_to new_session_url
    end
end
