# coding: utf-8

class WelcomesController < ApplicationController
  def index
  	do_and_respond do
  		@song = Song.find(9)
  	end
  end
end
