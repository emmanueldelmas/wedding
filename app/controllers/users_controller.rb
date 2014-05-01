# coding: utf-8
# 

class UsersController < ApplicationController

  def index
    do_and_respond do 
    end
  end

  def show
    do_and_respond(:show) do 
    end
  end

  def new
    return edit if @current_user
    do_and_respond(:new) do
      @current_user = User.new
      @object = params[:object]
    end
  end
  
  def edit
    do_and_respond(:edit, :show) do
      @object = params[:object]
    end
  end
  
  def create
    puts params
    return update if User.find_by(User.name_without_accent(params[:user]))
    do_and_respond(:show) do 
    end
  end
  
  def update
    do_and_respond(:show) do 
    end
  end
  
  def authenticate
    User.check_password(params[:password])
    @current_user = User.find_by(User.name_without_accent(params[:user]))
    session[:current_user_id] = @current_user[:id]
  end
end
