class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize, :clear_errors
  helper_method :current_user, :current_room, :clear_errors

  def current_user
    User.find(session[:user])
  end

  def current_room
    Room.find(params[:room_id] || params[:id])
  end

  def authorize
    redirect_to '/' if session[:user].nil?
  end

  def clear_errors
    session.delete(:err)
  end
end
