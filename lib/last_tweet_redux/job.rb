module LastTweetRedux
  class Job
    def initialize(redis_uri: '')
      @redis_client = redis_uri ? Redis.new : Redis.new(url: redis_uri)
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
      @connection ||= LastTweetRedux::Connection.new(screen_name: 'dakull')
    end

    def save_to_redis(html)
      @redis_client.set('last_tweet', html)
    end
  end
end
