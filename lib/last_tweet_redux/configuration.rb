require 'active_support/core_ext/hash'

module LastTweetRedux
  class Configuration
    attr_accessor :screen_name
    attr_accessor :redis_url
    attr_accessor :oauth_credentials

    def initialize(config_path)
      credentials = YAML.load_file(config_path).symbolize_keys

      self.oauth_credentials = credentials.fetch(:oauth).symbolize_keys
      self.screen_name       = credentials.fetch(:screen_name)
      self.redis_url         = credentials.fetch(:redis_url)
    end
  end
end
