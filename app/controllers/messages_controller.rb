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
      username: current_user.username,
      room_id:  current_room.id,
      html:     render_to_string('messages/_message',
        formats: [:html],
        layout: false,
        locals: { message_text: message.text,
                  timestamp:    message.created_at.strftime('%H:%M:%S'),
                  username:     current_user.username,
                  edited:       edited_message?(message.id),
                  id:           message.id })

    render nothing: true
  end

  def update
    Message.find(params[:id]).update(text: params[:message]['text'])

    ActionCable.server.broadcast 'messages',
      message_id: params[:id],
      message:    params[:message]['text'],
      update:     true

    render nothing: true
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to "/rooms/#{session[:id]}/messages"
  end
end
