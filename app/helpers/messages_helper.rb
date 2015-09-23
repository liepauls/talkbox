module MessagesHelper
  def message_author?(message)
    message.user_id == current_user.id
  end
end
