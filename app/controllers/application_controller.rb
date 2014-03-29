class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
protected

  def do_and_respond(on_success = :index, on_rescue = nil, &block)
    yield if block_given?
    render on_success
  # rescue
    # render on_rescue if on_rescue
    # redirect_to welcomes_path 
  end
end
