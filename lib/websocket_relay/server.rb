module WebsocketRelay
  class Server
    def self.call(url:, port:, task:, &block)
      endpoint = Async::HTTP::Endpoint.parse(
        url,
        alpn_protocols: Async::HTTP::Protocol::HTTP11.names
      )
      new(endpoint:, output_port: port).call(task:, &block)
    end

    def initialize(endpoint:, output_port:)
      @endpoint = endpoint
      @output_port = output_port
    end

    def call(task: Async::Task.current, &block)
      Async::WebSocket::Client.connect(@endpoint) do |websocket|
        task.async { Input.call(websocket:, port: @output_port) }
        Output.call(websocket, &block)
      end
    end
  end
end
