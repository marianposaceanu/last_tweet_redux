module LastTweetRedux
  class Job
    def initialize(opts)
      @options = opts
      @redis_client = opts.redis_url ? Redis.new : Redis.new(url: opts.redis_url)
    end

    def run
      tweet = connection.last_tweet_json
      hashed_data = formatter.process(tweet)

      save_to_redis(hashed_data.to_json)
    end

    private

    def formatter
      LastTweetRedux::Formatter
    end

    def connection
      @connection ||= LastTweetRedux::Connection.new({ screen_name: @options.handler }, @options.oauth_credentials)
    end

    def save_to_redis(html)
      @redis_client.set('last_tweet', html)
    end
  end
end
