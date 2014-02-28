class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def do_and_respond(on_success, on_rescue = nil, &block)
    yield
    render on_success
  rescue
    on_rescue ? render on_rescue : redirect welcome_path
  end
end
