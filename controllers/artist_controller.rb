require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/artist')


get '/artists' do
  @artists = Artist.all
  erb(:"/artist/index")
end

get '/artists/new' do
  erb(:"/artist/new")
end

post '/artists' do
  Artist.new(params).save
  redirect to '/albums/new'
end

get '/artists/:id' do
  @artist = Artist.find(params[:id].to_i)
  erb(:"/artist/show")
end

post '/artists/:id/delete' do
  artist = Artist.find(params[:id].to_i)
  artist.delete()
  redirect to '/artists'
end
