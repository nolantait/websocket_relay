# frozen_string_literal: true

require "dotenv/load"
require "socket"
require "async"
require "async/io"
require "async/io/stream"
require "async/http/endpoint"
require "async/websocket/client"
require "protocol/websocket/json_message"

require_relative "websocket_relay/version"
require_relative "websocket_relay/input"
require_relative "websocket_relay/output"
require_relative "websocket_relay/server"

module WebsocketRelay
  class Error < StandardError; end
  # Your code goes here...

  def self.call(url:, port:, &block)
    Server.call(url:, port:, &block)
  end

  def self.send_message(host:, port:, message:)
    Sync do
      Async::IO::Endpoint.tcp(host, port).connect do |client|
        payload = JSON.generate(message)
        client.write(payload)
        client.close_write
      end
    end
  end
end
