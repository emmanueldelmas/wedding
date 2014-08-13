# coding: utf-8
# 

class Admin::UsersController < ApplicationController
  
  before_action :authenticated_filter
  
  def index
    addresses
  end
  def addresses
    do_and_respond(:index) do
      if csv_request?
        @csv = User.addresses
        @filename = "adresses.csv"
      end
    end
  end
  def responses
    do_and_respond(:index) do
      if csv_request?
        @csv = User.responses
        @filename = "responses.csv"
      end
    end
  end

private
  def user_params
    params.require(:user).except!(:login, :password, :encrypted_password).permit!
  end
end
