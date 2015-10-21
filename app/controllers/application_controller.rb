class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "application"

  #Can receive an :err param. 1 = User could not be found @ HB
  def index
    render layout: "application"
  end
end
