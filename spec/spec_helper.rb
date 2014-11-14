require 'rubygems'
require 'bundler'
Bundler.require

RSpec.configure do |config|
  config.color = true
  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
end
