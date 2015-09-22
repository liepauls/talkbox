class MessagesController < ApplicationController
  include EmojiHelper

  def index
    render nothing: true
  end

  def create
    message = Message.create!(user_id: current_user.id,
                              room_id: params[:room_id],
                              text:    params[:message])

    ActionCable.server.broadcast 'messages',
      message_id: message.id,
      timestamp:  Time.now.utc.strftime('%H:%M'),
      username:   current_user.username,
      message:    message.text,
      room_id:    current_room.id

    render nothing: true
  end

  def update
    Message.find(params[:id]).update(text: params[:message]['text'])

    ActionCable.server.broadcast 'messages',
      message_id: params[:id],
      message:    params[:message]['text'],
      update:     true
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to "/rooms/#{session[:id]}/messages"
  end
end
