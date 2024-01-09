module WebsocketRelay
  class Output
    def self.call(websocket, &block)
      new(websocket).call(&block)
    end

    def initialize(websocket)
      @websocket = websocket
    end

    def call(&block)
      while message = @websocket.read
        next unless message = Protocol::WebSocket::JSONMessage.wrap(message)
        block.call(message.to_h)
      end
    end
  end
end
