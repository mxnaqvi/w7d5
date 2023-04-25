class UsersController < ApplicationController
    def index
        @users = User.all
        render :index
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
           login!(@user)  
           flash[:notice] = "Successfully created user."
           redirect_to user_url(@user)
        else
            flash.now[:errors] = @users.errors.full_messages
        end
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def destroy 
        @user = User.find(params[:id])
        @user.destroy
    end

    private

    def user_params
        params.require(:user).permit(:username, :password_digest, :session_token)
    end
end