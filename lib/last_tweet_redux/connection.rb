require 'net/http'
require 'yaml'
require 'json'

module LastTweetRedux
  class Connection
    BASE_TWITTER_API  = 'https://api.twitter.com/1.1'
    USER_TIMELINE_API = "#{BASE_TWITTER_API}/statuses/user_timeline.json"

    def initialize(screen_name, oauth_credentials)
      @uri_query_params  = default_uri_query_params(screen_name)
      @oauth_credentials = oauth_credentials
    end

    def last_tweet_json
      headers = authorization_header(USER_TIMELINE_API, @uri_query_params, @oauth_credentials)
      uri = URI(USER_TIMELINE_API).tap { |u| u.query = URI.encode_www_form(@uri_query_params) }
      response = run_get_request(uri, headers)

      JSON.parse(response.body).first
    end

    private

    def run_get_request(uri, headers)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      headers.each do |header, value|
        request[header] = value
      end

      http.request(request)
    end

    def authorization_header(uri, uri_query_params, oauth_credentials)
      oauth_header = OauthHeader.create(uri, uri_query_params, oauth_credentials)

      { 'Authorization' => oauth_header.to_s }
    end

    def default_uri_query_params(screen_name)
      { count: 1, screen_name: screen_name, exclude_replies: true }
    end
  end
end
