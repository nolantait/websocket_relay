require "eth"
require "./lib/websocket_relay"

def topic
  event_signature = "Sync(uint112,uint112)"
  hash = Eth::Util.bin_to_hex(Eth::Util.keccak256(event_signature))
  "0x#{hash}"
end

inputs = [
  {
    indexed: false,
    internalType: "uint112",
    name: "reserve0",
    type: "uint112"
  },
  {
    indexed: false,
    internalType: "uint112",
    name: "reserve1",
    type: "uint112"
  }
]

payload = {
  id: 1,
  jsonrpc: "2.0",
  method: "eth_subscribe",
  params: [
    "logs",
    {
      address: "0x844EB5C280F38c7462316AaD3F338eF9bDa62668".downcase,
      topics: [topic]
    }
  ]
}

response = WebsocketRelay.send_message(
  host: "localhost",
  port: 4481,
  message: payload
)

puts "Response: #{response}"
