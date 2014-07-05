# Last Tweet redux

This gem does one simple action: fetches your last tweet:

- run as a background process
- fetch your last tweet
- properly formats it (think about links, handlers, hashtags etc.)
- save the result to Redis.

## Why

This is just extracted functionality from my Rails app. I don't see the point of adding a couple of heavy gems just to retrieve my last tweet.

In my previous implementation this generated added complexity:

- get the tweet from the backend then cache it - requires gems
- get the tweet via JS and then cache it via local storage - makes the front-end slow
- do an async call to cached backend endpoint - cache it via local storage and via backend - but as the tweet loads for the 1st time I have an empty or loading div

Solution:

Run a trivial background process that just fetches the last tweet and saves it to a Redis backend.

### Requirements

Search redux requires at least Ruby >= 2.0 and the [Redis gem](https://github.com/redis/redis-rb) in your app.

## Installation

Include the gem in your Gemfile:

```ruby
gem 'last_tweet_redux'
```

## Quick start

wip

## License (MIT)

Copyright (c) 2013 Marian Posaceanu

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


