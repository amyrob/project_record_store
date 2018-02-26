require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('controllers/album_controller.rb')
require_relative('controllers/artist_controller.rb')

get '/' do
  @albums = Album.all
  erb(:index)
end
