# coding: utf-8
# 

class Admin::UsersController < ApplicationController
  
  before_action :authenticated_filter
  
  def addresses
    do_and_respond(:addresses) do
      if csv_request?
        @csv = User.addresses
        @filename = "adresses.csv"
      else
        @users = User.users_with_address
      end
    end
  end
  def responses
    do_and_respond(:responses) do
      if csv_request?
        @csv = User.responses
        @filename = "responses.csv"
      else
        @users = User.users_with_response
      end
    end
  end
  def messages
    do_and_respond(:messages) do
      @users = User.all
    end
  end

private
  def user_params
    params.require(:user).except!(:login, :password, :encrypted_password).permit!
  end
end
