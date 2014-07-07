# Last Tweet Redux

This gem does one simple action: fetches your last tweet (at a specified interval) and saves it (properly formatted) to Redis.

## Quick start

###### Include the gem in your Gemfile and do a bundle install

```ruby
gem 'last_tweet_redux', require: false
```

Run the process as a daemon: `last-tweet -d -c twitter.yml`

Configuration file should look like:

```yml
screen_name: 'twitter_name'
redis_url: 'redis://:p4ssw0rd@10.0.1.1:6380/15'
interval: 1
oauth:
  consumer_key: 'your-consumer-key'
  consumer_secret: 'your-consumer-secret-key'
  token : 'your-oauth-token'
  token_secret: 'your-oauth-token-secret'
```

__note__: interval is an Integer for the number of minutes the process should hit the Twitter API

You can kill the process with: `last-tweet -k -P /var/run/myapp.pid`

###### In your application add the Redis gem and retrieve your tweet

In your controller:

```ruby
# rest of your controller
  def get_last_tweet
    client = Redis.new

    last_tweet      = JSON.parse(client.get('last_tweet'))
    last_tweet_body = last_tweet.body.html_safe # for Rails
    last_tweet_url  = last_tweet.url
    last_tweet_data = last_tweet.created_at
  end
```

Then in your view:

```erb
# rest of your view
  <div id="tweet">
    <%= last_tweet_body %>
  </div>
```
###### Capistrano commands for startin/killing the daemon

```ruby
after 'unicorn:restart' do
  run "cd #{current_path}; chruby-exec #{ruby_version} -- bundle exec last-tweet -k -P tmp/last_tweet.pid -c config/last_tweet.yml"
  run "cd #{current_path}; chruby-exec #{ruby_version} -- bundle exec last-tweet -d -P tmp/last_tweet.pid -l tmp/last_tweet.log -c config/last_tweet.yml"
end
```

__note__: the example uses chruby feel free to update/remove if the case

#### Requirements

Last Tweet Redux requires at least Ruby >= 2.0 and the [Redis gem](https://github.com/redis/redis-rb) in your app.

#### Detailed configuration parameters for the executable

```
  -P, --pid FILE            save PID in FILE when using -d option.
                            (default: /var/run/last_tweet_redux.pid)
  -d, --daemon              Daemonize mode
  -l, --log FILE            Logfile for output
                            (default: /var/log/last_tweet_redux.log)
  -k, --kill [PID]         Kill specified running daemons - leave blank to kill all.
  -u, --user USER           User to run as
  -G, --group GROUP         Group to run as
  -c, --config FILE.yml     Config path
  -?, --help                Display this usage information.
```

## Why

This is just extracted functionality from my Rails app. I don't see the point of adding a couple of heavy gems just to retrieve my last tweet.

In my previous implementation this generated unnecessary complexity:

- get the tweet from the back-end then cache it - requires gems, must be cached for a long time as an API call takes some time
- get the tweet via JavaScript and then cache it via local storage - makes the front-end slow adds unnecessary JS logic
- do an asynchronously call to cached back-end endpoint - cache it via local storage and via back-end - but as the tweet loads for the 1st time I have an empty or loading div - you get the "best" of both worlds

Solution:

Run a trivial background process that just fetches the last tweet and saves it to a Redis back-end this can also be a form of a microservice.

## License (MIT)

Copyright (c) 2014 Marian Posaceanu

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
