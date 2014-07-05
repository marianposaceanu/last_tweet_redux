module LastTweetRedux
  class Configuration
    include Utils

    attr_accessor :handler
    attr_accessor :redis_url
    attr_accessor :oauth_credentials

    def initialize(config_path)
      credentials = symbolize_keys(YAML.load_file(config_path))

      self.oauth_credentials = symbolize_keys(credentials.fetch(:oauth))
      self.handler = credentials.fetch(:handler)
      self.redis_url = credentials.fetch(:redis_url)
    end
  end
end
