require 'rubygems'
require 'sinatra/base'
class ppoApp < Sinatra::Base
  get '/hello' do
    'Good Sunday Morning!'
  end
end
run ppoApp

