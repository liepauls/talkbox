module ApplicationHelper
  def ws_messages_url
    if Rails.application.middleware.middlewares.any? { |m| m.name == "WebsocketMiddleware" }
      "ws://#{request.host}:#{request.port}"
    else
      "ws://#{request.host}:28080"
    end
  end
end
