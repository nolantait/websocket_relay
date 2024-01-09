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
      Async do
        @endpoint.accept do |client|
          message = client.read
          next unless message
          next if message.empty?

          payload = JSON.parse(message, symbolize_names: true)
          send_request(payload)
        end
      end
    end

    def send_request(payload)
      message = Protocol::WebSocket::JSONMessage.generate(payload)
      message.send(@websocket)
      @websocket.flush
    end
  end
end
