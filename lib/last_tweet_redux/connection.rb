require 'net/http'
require 'yaml'
require 'json'

module LastTweetRedux
  class Connection
    BASE_TWITTEER_API_URL = 'https://api.twitter.com/1.1'

    def initialize(opts = {})
      @options = default_options.merge(opts)
    end

    def last_tweet_json
      JSON.parse(response.body).first
    end

    private

    def raw_uri
      @raw_uri ||= "#{BASE_TWITTEER_API_URL}/statuses/user_timeline.json"
    end

    def uri
      @uri ||= URI(raw_uri).tap { |u| u.query = URI.encode_www_form(@options) }
    end

    def response
      http = Net::HTTP.new(uri.host, uri.port).tap { |o| o.use_ssl = true }

      request = Net::HTTP::Get.new(uri).tap do |req|
        req['Authorization'] = last_tweet_header(@options, raw_uri).to_s
      end

      http.request(request)
    end

    def last_tweet_header(params, uri)
      oauth_header = LastTweetRedux::OauthHeader.new(params: params)
      oauth_header.last_tweet_header(uri)
    end

    def default_options
      { count: 1, screen_name: '', exclude_replies: true }
    end
  end
end
