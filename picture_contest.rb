#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require
require "sinatra/reloader" if development?

Mongoid.load!("config/mongoid.yml")
S3Config = YAML.load(ERB.new(File.read("config/aws_s3.yml")).result)[settings.environment]



get '/' do ## show the landing page with an upload form
  #not much dynamic stuff to do here yet
  
  haml :index
end

post '/submit' do ## accept user submission
  #check if it's valid
  
  #upload picture to S3
  AWS::S3::Base.establish_connection!({
    :access_key_id => S3Config[:access_key_id],
    :secret_access_key => S3COnfig[:secret_access_key]
  })
  
  AWS::S3::S3Object.store filename, File.open(tmpfile), S3Config[:bucket]
  #store metadata in mongo, including path to image
  
  #get the id from mongo
  
  #redirect to the pic page
  redirect to('/pic/%s' % pic_id)
end

get '/pic/:id' do |id| ## show the picture with share links
  #load the requested id
  
  #get the image path on s3
  
  #show the image on the page
  haml :pic
end
