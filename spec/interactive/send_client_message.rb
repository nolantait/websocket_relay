require "debug"
require "socket"
require "protocol/websocket/json_message"

client = TCPSocket.new("localhost", 4481)

payload = {
  id: 1,
  jsonrpc: "2.0",
  method: "eth_blockNumber",
  params: []
}

Protocol::WebSocket::JSONMessage.generate(payload).tap do |message|
  puts "Sending #{message.to_h}"
  client.write(message.to_h.to_json)
end

client.close
