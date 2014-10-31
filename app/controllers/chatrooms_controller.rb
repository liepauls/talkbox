class ChatroomsController < ApplicationController

	def index
	end

	def new
		if params[:id]
			Room.create(name: params[:id], password: params[:pass])
			redirect_to "/chatroom/#{params[:id]}"
		end
	end

	# TODO Rename to show
  def show
  	@room = Room.find_by!(name: params[:room])
  	@messages = @room.messages
  	session[:room] = params[:room]
  end
end






