require 'active_support/core_ext/hash'
require 'active_support/core_ext/integer'

module LastTweetRedux
  class Configuration
    attr_accessor :screen_name
    attr_accessor :redis_url
    attr_accessor :oauth_credentials
    attr_accessor :interval

    def initialize(config_path)
      credentials = YAML.load_file(config_path).symbolize_keys

      self.oauth_credentials = credentials.fetch(:oauth).symbolize_keys
      self.screen_name       = credentials.fetch(:screen_name)
      self.redis_url         = credentials.fetch(:redis_url)
      self.interval          = credentials.fetch(:interval).to_i.minutes
    end
  end
end
