require 'simple_oauth'

module LastTweetRedux
  class OauthHeader
    include Utils

    def initialize(oauth_credentials, params = {})
      @oauth_credentials = oauth_credentials
      @params = params
    end

    def last_tweet_header(uri)
      oauth_auth_header(:get, uri, @params)
    end

    private

    def oauth_auth_header(method, uri, params = {})
      SimpleOAuth::Header.new(method, uri, params, @oauth_credentials)
    end
  end
end
