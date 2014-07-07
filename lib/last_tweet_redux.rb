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

        puts job.instance_eval { Marshal.load @client.get('last_tweet') }

        GC.start

        sleep config.interval
      end
    end
  end
end
