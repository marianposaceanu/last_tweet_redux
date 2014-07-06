require 'redis'

module LastTweetRedux
  class Job
    def initialize(opts)
      @options = opts
      @client  = opts.redis_url ? Redis.new : Redis.new(url: opts.redis_url)
    end

    def run
      last_tweet = connection.retrieve_tweet
      formatted_last_tweet = Formatter.process(last_tweet)

      save(formatted_last_tweet.to_json)
    end

    private

    def connection
      @connection ||= Connection.new(@options.screen_name, @options.oauth_credentials)
    end

    def save(html)
      @client.set('last_tweet', html)
    end
  end
end
