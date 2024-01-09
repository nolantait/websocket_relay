module WebsocketRelay
  class Server
    def self.call(url:, port:, &block)
      endpoint = Async::HTTP::Endpoint.parse(
        url,
        alpn_protocols: Async::HTTP::Protocol::HTTP11.names
      )
      new(endpoint:, output_port: port).call(&block)
    end

    def initialize(endpoint:, output_port:)
      @output_port = output_port
      @websocket = Async::WebSocket::Client.connect(endpoint)
    end

    def call(&block)
      Async do
        Output.call(@websocket, &block)
      end

      Async do |task|
        Input.call(websocket: @websocket, port: @output_port)
      end
    end
  end
end
