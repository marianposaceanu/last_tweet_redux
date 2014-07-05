require 'twitter-text'

module LastTweetRedux
  module Formatter extend self
    extend Twitter::Autolink

    def process(raw_tweet)
      {
        body: auto_link(raw_tweet['text'], target: '_blank', url_entities: raw_tweet['entities']['urls']),
        created_at: raw_tweet['created_at']
      }
    end
  end
end
