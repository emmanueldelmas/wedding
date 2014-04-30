class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :current_user, :authenticated
  
protected

  def do_and_respond(on_success = :index, on_rescue = nil, &block)
    yield if block_given?
    render on_success
  # rescue
    # render on_rescue if on_rescue
    # redirect_to welcomes_path 
  end
  
private
  
  def current_user
    @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end
  
  def authenticated
    @authenticated ||= session[:authenticated] == "authenticated"
  end
end
