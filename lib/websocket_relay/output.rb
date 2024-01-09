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
        puts "Received message: #{message.to_h}"
        block.call(message.to_h)
      end

      puts "Websocket closed"
    end
  end
end
