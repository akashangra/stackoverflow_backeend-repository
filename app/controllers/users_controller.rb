class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  wrap_parameters :user, include: [:name, :email, :password,:password_confirmation]


  def create
    puts "in create method backend"
    puts params
    @user = User.new(user_params)
    @user.save
    puts @user.errors.messages

  end

  def login
    puts "in login"

    user = User.find_by(id: params[:id])
    if( user && user.authenticated?(:remember, params[:remember_me]))
      puts "already login"
      return
    end


    user = User.find_by(email: params[:user][:email])
    if(user && user.authenticate( params[:user][:password] ) )
      puts "successful"
      user.remember
      #user["remember_me"] = new_token
      user_json = user.as_json
      user_json[:remember_me] = user.remember_token

      render json: user_json.to_json
    else
      puts "unsuccessful"
    end
    puts params
  end

  def data
    puts "in data"
    render json: User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end

  def update
    puts "in update backend"
    user = User.find_by(id: params[:id])
    if( user.update_attributes( user_params ) )
      puts "updated"
    else
      puts user.errors.messages
    end
  end
end
