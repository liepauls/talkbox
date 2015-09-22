module MessagesHelper
  def edited_message?(id)
    message = Message.find(id)
    message.created_at != message.updated_at ? '✎' : ''
  end

  def message_author?(message)
    message.user_id == current_user.id
  end
end
