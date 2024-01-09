require "debug"
require "./lib/websocket_relay"

Async do
  WebsocketRelay.call(
    url: ENV.fetch("RELAY_URL"),
    port: 4481
  ) do |message|
    puts "MESSAGE: #{message}"
  end
end
