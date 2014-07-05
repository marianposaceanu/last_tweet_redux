require 'simple_oauth'

module LastTweetRedux
  class OauthHeader
    include Utils

    def initialize(file_path: 'twitter.yml', params: {})
      @file_path = file_path
      @params = params
    end

    def last_tweet_header(uri)
      oauth_auth_header(:get, uri, @params)
    end

    private

    def oauth_auth_header(method, uri, params = {})
      SimpleOAuth::Header.new(method, uri, params, credentials)
    end

    def credentials
      @credentials ||= symoblize_keys(YAML.load_file(@file_path))
    end
  end
end
