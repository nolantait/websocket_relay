# frozen_string_literal: true

require "socket"
require "async"
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

  def self.call(url:, port:)
    Async do |task|
      Server.call(url:, port:, task:)
    end
  end

  def self.send_message(host:, port:, message:)
    client = TCPSocket.new(host, port)
    client.write(JSON.generate(message))
    client.close_write
    client.read.tap do |response|
      client.close
    end
  end
end
