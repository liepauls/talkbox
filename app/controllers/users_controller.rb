class UsersController < ApplicationController
  layout 'default'
  skip_before_action :logged_in?, :clear_errors, :verify_authenticity_token
  before_action      :signed_in, only: [:index, :new, :create]

  def index
    if params[:password]
      user = User.find_by(username: params[:username])

      if user && BCrypt::Password.new(user.password) == params[:password]
        session[:user] = user.id
        session[:notification] = 'You have successfully logged in!'
        redirect_to '/rooms'
      else
        session[:err] = 'Incorrect username or password!'
      end
    end
  end

  def create
    user = User.new(username: params[:username], password: params[:password])

    if user.save
      user.update(password: BCrypt::Password.create(params[:password]))
      session[:user] = user.id
      session[:notification] = 'You have successfully created a new account!'
      redirect_to rooms_path
    else
      session[:err] = user.errors.full_messages.first
      redirect_to new_path
    end
  end

  def logout
    session.delete(:user)
    redirect_to '/'
  end

  def signed_in
    redirect_to rooms_path unless session[:user].nil?
  end
end
