# coding: utf-8

class SongsController < ApplicationController
	def index
		do_and_respond
	end
	def show
		do_and_respond(:show, :index) do
  		@song = Song.find(params[:id].to_i)
  	end
	end

protected

	def do_and_respond(on_success = :index, on_rescue = nil, &block)
    yield if block_given?
    render on_success
  # rescue
    # render on_rescue if on_rescue
    # redirect_to welcomes_path 
  end
end
