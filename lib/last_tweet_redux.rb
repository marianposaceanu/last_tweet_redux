require 'redis'
require 'pry'

require_relative 'last_tweet_redux/utils'
require_relative 'last_tweet_redux/configuration'
require_relative 'last_tweet_redux/oauth_header'
require_relative 'last_tweet_redux/connection'
require_relative 'last_tweet_redux/formatter'
require_relative 'last_tweet_redux/job'

module LastTweetRedux
  module Process extend self
    def init(config_path)
      config = Configuration.new(config_path)
      job    = Job.new(config)

      loop do
        job.run

        s = job.instance_eval { @redis_client.get('last_tweet') }

        puts s

        GC.start

        sleep 1 * 30
      end
    end
  end
end
