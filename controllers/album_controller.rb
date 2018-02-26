require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/album')

get '/albums' do
  @albums = Album.all
  erb(:"/album/index")
end

get '/albums/new' do
  @artists = Artist.all
  erb(:"/album/new")
end

post '/albums' do
  Album.new(params).save
  redirect to '/'
end
