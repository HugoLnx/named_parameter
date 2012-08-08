# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.version = "1.0.0"
  gem.name = "named_parameter"
  gem.homepage = "http://github.com/hugolnx/named_parameter"
  gem.license = "MIT"
  gem.summary = %Q{Allows named parameter in ruby}
  gem.description = %Q{Allows named parameter in ruby}
  gem.email = "hugolnx@gmail.com"
  gem.authors = ["Hugo Roque (a.k.a HugoLnx)"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new
