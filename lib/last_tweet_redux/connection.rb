require 'net/http'
require 'yaml'
require 'json'

module LastTweetRedux
  class Connection
    BASE_TWITTER_API  = 'https://api.twitter.com/1.1'
    USER_TIMELINE_API = "#{BASE_TWITTER_API}/statuses/user_timeline.json"

    def initialize(screen_name, oauth_credentials)
      @options           = default_options(screen_name)
      @oauth_credentials = oauth_credentials
    end

    def last_tweet_json
      JSON.parse(response.body).first
    end

    private

    def uri
      @uri ||= URI(USER_TIMELINE_API).tap { |u| u.query = URI.encode_www_form(@options) }
    end

    def response
      http = Net::HTTP.new(uri.host, uri.port).tap { |o| o.use_ssl = true }

      request = Net::HTTP::Get.new(uri).tap do |req|
        req['Authorization'] = last_tweet_header(@options, USER_TIMELINE_API).to_s
      end

      http.request(request)
    end

    def last_tweet_header(params, uri)
      oauth_header = LastTweetRedux::OauthHeader.new(@oauth_credentials, params)
      oauth_header.last_tweet_header(uri)
    end

    def default_options(screen_name)
      { count: 1, screen_name: screen_name, exclude_replies: true }
    end
  end
end
