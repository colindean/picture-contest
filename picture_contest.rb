#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require

get '/' do
  'Picture contest!'
end
