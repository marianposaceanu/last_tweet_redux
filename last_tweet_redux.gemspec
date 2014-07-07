# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

require 'last_tweet_redux/version'

Gem::Specification.new do |s|
  s.name        = 'last_tweet_redux'
  s.version     = LastTweetRedux::VERSION.dup
  s.author      = ['Marian Posaceanu']
  s.email       = ['contact@marianposaceanu.com']
  s.homepage    = 'https://github.com/dakull/last_tweet_redux'
  s.summary     = %q{Just fetches your last tweet and saves it to Redis}
  s.description = %q{Runs a trivial background process that just fetches the last tweet and saves it to a Redis backend this can also be a form of a microservice.}
  s.executables = %w(last-tweet)
  s.files       = Dir["lib/**/*.rb"]
  s.license     = 'MIT'

  s.add_dependency('redis', '~> 3.1')
  s.add_dependency('dante', '~> 0.2')
  s.add_dependency('simple_oauth', '~> 0.2')
  s.add_dependency('twitter-text', '~> 1.9')
  s.add_dependency('activesupport', '~> 4')

  # s.add_development_dependency('rspec')
  # s.add_development_dependency('webmock', '~> 1.17')
  # s.add_development_dependency('pry')
end
