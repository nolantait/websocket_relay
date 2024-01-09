require "socket"
require "json"

client = TCPSocket.new("localhost", 4481)

payload = {
  id: 1,
  jsonrpc: "2.0",
  method: "eth_blockNumber",
  params: []
}

client.write(nil) # Ignores nil messages
client.write("") # Ignores empty messages
client.write(JSON.generate(payload))
client.close
