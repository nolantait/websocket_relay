# WebsocketRelay

I was building an event sourced service with ruby that needed to maintain
a persistent connection to a web socket. I wanted the ability to send messages
through a relay so I could manage requests to and from the socket without
managing the connection directly within my event sourced system.

## Installation

Not currently released to RubyGems so you can pull this repo and reference it as
a local gem for now.

## Usage

Starting the server:

```ruby
require "websocket_relay"

Async do
    WebsocketRelay.call(
      url: "ws://localhost:8545", # The url to relay
      port: 4481                  # Which port on localhost to relay the connection from
    ) do |message|
      puts "MESSAGE: #{message}"  # Do something with each message
    end
end
```

Sending a message to the relay:

```ruby
require "websocket_relay"

payload = {
  id: 1,
  jsonrpc: "2.0",
  method: "eth_blockNumber",
  params: []
}

WebsocketRelay.send_message(
  host: "localhost",
  port: 4481,
  message: payload
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nolantait/websocket_relay.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
