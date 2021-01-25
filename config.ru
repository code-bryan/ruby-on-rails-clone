#config.ru
require 'rubygems'
require 'bundler'
Bundler.require

require "./app"

use Rack::Reloader, 0
use Rack::Static, urls: ['/assets', '/javascript'], root: "resources"

run App.new