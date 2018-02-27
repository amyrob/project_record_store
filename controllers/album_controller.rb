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

get '/albums/:id' do
  @album = Album.find(params[:id].to_i)
  erb(:"/album/show")
end

get '/albums/:id/edit' do
  @album = Album.find(params[:id])
  erb(:"/album/edit" )
end

post '/albums/:id/edit' do
  Album.new(params).update
  redirect to '/albums'
end

post '/albums/:id/delete' do
  album = Album.find(params[:id].to_i)
  album.delete()
  redirect to '/albums'
end
