class UsersController < ApplicationController

  def new
  	if params[:username]
	  	session[:user] = params[:username]
	  	User.create(username: session[:user])
	   	redirect_to "/chatrooms"
	  end
  end
end
