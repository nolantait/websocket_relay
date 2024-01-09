module WebsocketRelay
  class Output
    def self.call(websocket)
      new(websocket).call
    end

    def initialize(websocket)
      @websocket = websocket
    end

    def call
      while message = @websocket.read
        next unless message = Protocol::WebSocket::JSONMessage.wrap(message)

        puts "Received #{message.to_h}"
      end
    end
  end
end
