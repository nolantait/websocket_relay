module WebsocketRelay
  class Input
    def self.call(websocket:, port:)
      endpoint = Async::IO::Endpoint.tcp("0.0.0.0", port)
      new(websocket, endpoint).call
    end

    def initialize(websocket, endpoint)
      @websocket = websocket
      @endpoint = endpoint
    end

    def call
      @endpoint.accept do |client|
        payload = JSON.parse(client.read, symbolize_names: true)
        send_request(payload)
      rescue JSON::ParserError
        puts "Invalid JSON: #{payload}"
      end
    end

    def send_request(payload)
      Protocol::WebSocket::JSONMessage.generate(payload).tap do |message|
        puts "Sending #{message.to_h}"
        message.send(@websocket)
        @websocket.flush
      end
    end
  end
end
