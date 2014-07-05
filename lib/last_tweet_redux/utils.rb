module LastTweetRedux
  module Utils
    def symbolize_keys(hash)
      hash.each_with_object({}) { |(k,v), h| h[k.to_sym] = v }
    end
  end
end
