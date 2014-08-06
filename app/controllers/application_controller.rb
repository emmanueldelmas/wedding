class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :current_user, :authenticated
  after_action :current_user, :authenticated
  
protected

  def do_and_respond(on_success = :index, on_rescue = nil, &block)
    yield if block_given?
    if zip_request?
      if @send_file
        return send_file @file_path, filename: @filename, type: "application/zip"
      end
    elsif csv_request?
    elsif pdf_request?
      if @send_file
        return send_file @file_path, filename: @filename, type: "application/pdf", disposition: "inline"
      elsif @pdf
        return send_data @pdf.render, :filename => @filename, :type => "application/pdf", disposition: "inline"
      end
    end
    on_success =~ /redirect_to_/ ? redirect_to( send( on_success.gsub(/redirect_to_/, ""))) : render( on_success)
  rescue
    on_rescue =~ /redirect_to_/ ? redirect_to( send( on_rescue.gsub(/redirect_to_/, ""))) : render( on_rescue) if on_rescue
    redirect_to welcomes_path
  end
  
private
  
  def current_user
    cookies.permanent[:current_user_id] = @current_user[:id] if @current_user && @current_user[:id]
    @current_user ||= cookies[:current_user_id] && User.find_by(id: cookies[:current_user_id])
  end
  
  def authenticated
    session[:authenticated] = @authenticated if @authenticated
    @authenticated ||= session[:authenticated]
  end

  def html_request?;    !csv_request? && !pdf_request?;  end

  def csv_request?
    @current_uri = request.original_fullpath.split( '?').first
    @current_uri =~ /\.csv\Z/
  end
  
  def pdf_request?
    @current_uri = request.original_fullpath.split( '?').first
    @current_uri =~ /\.pdf\Z/
  end
  
  def zip_request?
    @current_uri = request.original_fullpath.split( '?').first
    @current_uri =~ /\.zip\Z/
  end
end
