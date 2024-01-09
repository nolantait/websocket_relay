require "debug"
require "socket"
require "json"

require "./lib/websocket_relay"

payload = {
  id: 1,
  jsonrpc: "2.0",
  method: "eth_blockNumber",
  params: []
}

response = WebsocketRelay.send_message(
  host: "localhost",
  port: 4481,
  message: payload
)

puts "Response: #{response}"
