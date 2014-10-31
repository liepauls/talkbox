class MessagesController < ApplicationController
  def new
  	user_id = User.find_by(username: session[:user])['id']
  	room_id = Room.find_by(name: session[:room])['id']

  	Message.create(user_id: user_id, room_id: room_id, text: params[:message])
  	redirect_to "/chatroom/#{session[:room]}"
  end
end
