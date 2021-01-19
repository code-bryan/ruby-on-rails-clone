#config.ru
require 'rubygems'
require 'bundler'
Bundler.require

require "./server"

run Server.new