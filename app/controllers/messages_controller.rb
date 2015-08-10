class MessagesController < ApplicationController
  def index
  end

  def show
    # byebug
  end

  def new
  	user_id = User.find_by(username: session[:user])['id']
  	room_id = Room.find_by(id: session[:id])['id']

  	Message.create(user_id: user_id, room_id: room_id, text: params[:message])
  	redirect_to "/chatrooms/#{session[:id]}"
  end

  def edit
    if params[:submit]
      @new_text = params[:new_text]
      update
    end
  end

  def update
    Message.find(params[:id]).update(text: @new_text)
    redirect_to "/chatrooms/#{params[:chatroom_id]}/messages"
  end

  def destroy
    Message.find_by(id: params[:id]).destroy
    redirect_to "/chatrooms/#{params[:chatroom_id]}/messages"
  end
end
