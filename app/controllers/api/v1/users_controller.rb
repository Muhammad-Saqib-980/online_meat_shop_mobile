class Api::V1::UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
  
    # REGISTER
    def create
      @user = User.create(user_params)
      if @user.valid?
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
      else
        render json: {error: @user.errors.full_messages},status: 400
      end
    end
    # LOGGING IN
    def login
      myparams=user_params
      @user = User.find_by(email: myparams[:email])
      puts '---'*40
      puts params[:email]
      if @user && @user.authenticate(myparams[:password])
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
      else
        render json: {error: ["Invalid username or password"]},status: 400
      end
    end
  
  
    def auto_login
      render json: @user
    end
  
    private
  
    def user_params
      params.require(:user_session).permit(:email,:password)
    end
  
  end