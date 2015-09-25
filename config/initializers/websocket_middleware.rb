class WebsocketMiddleware
  def initialize(app, options={})
    @app = app
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      ActionCable.server.call(env)
    else
      @app.call(env)
    end
  end
end

if Rails.env.production? || ENV['WS']
  Rails.application.config.middleware.insert_after Rack::Runtime, WebsocketMiddleware
end
