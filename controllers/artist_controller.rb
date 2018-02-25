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
  redirect to '/artists'
end
