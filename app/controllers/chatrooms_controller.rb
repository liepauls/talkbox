class ChatroomsController < ApplicationController

	def index
	end

	def new
		if params[:submit]
			Room.create(name: params[:name], password: params[:pass])
			redirect_to "/chatrooms/#{params[:id]}"
		end
	end

  def show
  	@id = Room.find_by!(id: params[:id])
  	@messages = @id.messages
  	session[:id] = params[:id]
  end

  def edit
  	if params[:submit]
	  	@room = Room.find_by!(id: params[:id])
	  	@new_name = params[:new_name]
	  	@room_pwd = params[:room_pwd]
	  	@new_room_pwd = params[:new_room_pwd]
  		update
  	end
  end

  def update
  	@room.update(name: @new_name) if @new_name != '' && @room_pwd == @room['password']

  	if @new_room_pwd != '' && @room_pwd == @room['password']
  		@room.update(password: @new_room_pwd)
    end
  	redirect_to "/chatrooms"
  end

  def destroy
    Room.find_by(id: params[:id]).destroy
    redirect_to "/chatrooms"
  end

	def authenticate
  	if params[:room_pwd] == Room.find_by(id: params[:room])['password']
	  	redirect_to "/chatrooms/#{params[:room]}"
	  end
	end
end
