require 'simple_oauth'

module LastTweetRedux
  module OauthHeader
    extend self

    def create(uri, uri_query_params, oauth_credentials)
      SimpleOAuth::Header.new(:get, uri, uri_query_params, oauth_credentials)
    end
  end
end
