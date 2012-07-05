Social playlists for your next gathering.

Powered by: EchoNest, Rdio, and Riak.

To run the tests:

1. Install Riak (if you haven't already):
```
$ brew install riak
```

2. Install Mongo (if you haven't already):
```
$ brew install mongodb
```

3. Start Riak
```
$ riak start
$ riak ping
=> pong
```

4. Run the specs
```
$ rake spec
```