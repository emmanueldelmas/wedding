# coding: utf-8
# 

class UsersController < ApplicationController
  def new
  end
  
  def create
    return update if User.find_by(User.name_without_accent(params[:user]))
  end
  
  def update
  end
  
  def authenticate
    User.check_password(params[:password])
    @current_user = User.find_by(User.name_without_accent(params[:user]))
    session[:current_user_id] = @current_user[:id]
  end
end
