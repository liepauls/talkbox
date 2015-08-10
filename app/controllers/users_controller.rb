class UsersController < ApplicationController

	skip_before_action :authorize

	def index
		redirect_to '/chatrooms' if session[:user]

		if params[:password] && params[:password] == User.find_by(username: params[:username])[:password]
			session[:user] = params[:username]
			redirect_to '/chatrooms'
		end
	end

  def new
  	if params[:username]
	  	user = User.create(username: params[:username], password: params[:password])
	   	session[:user] = params[:username]
	   	if user.errors.empty?
	   		redirect_to '/chatrooms'
	   	else
	   		flash[:error] = user.errors.full_messages.join(' and ')
	   	end
	  end
  end

  def logout
  	session[:user] = nil
  	redirect_to '/users'
  end

end
