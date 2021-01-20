#config.ru
require 'rubygems'
require 'bundler'
Bundler.require

require "./app"

use Rack::Reloader, 0

run App.new