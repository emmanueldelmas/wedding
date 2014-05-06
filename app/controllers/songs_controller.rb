# coding: utf-8

class SongsController < ApplicationController
	def index
		do_and_respond
	end
	def show
		do_and_respond(:show, :index) do
      @song = Song.find(params[:id].to_i)
      if pdf_request?
        @send_file = true
        @filename = @song.filename
        @file_path = "#{Rails.root}/public/partitions/#{@filename}"
        send_file @file_path, filename: @filename, type: "application/pdf"
      else
  		  @song = Song.find(params[:id].to_i)
      end
  	end
	end

protected
end
