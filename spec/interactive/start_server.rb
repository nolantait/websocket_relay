require "debug"
require "./lib/websocket_relay"

WebsocketRelay.call(
  url: "ws://localhost:8545",
  port: 4481
) do |message|
  puts "MESSAGE: #{message}"
end
