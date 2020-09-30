require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/albums') do
  @albums = Album.sort
  erb(:albums)
end

get('/albums/sold') do
  @sold_albums = Album.sold()
  erb(:sold)
end


get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
get('/albums/sold/:id') do
  @album = Album.find_sold(params[:id].to_i())
  erb(:sold_album)
end
 
get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

post('/albums/search') do
  name = params[:search]
  @result = Album.search(name)
  erb(:search)
end

post('/albums/sold') do
  @album = Album.find(params[:id].to_i())
  @album.sold
  @sold_albums = Album.sold()
  erb(:sold)
end

post('/albums') do
 name = params[:album_name]
 album = Album.new(name, nil)
 album.save()
 @albums = Album.sort()
 erb(:albums)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @albums = Album.sort()
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.sort()
  erb(:albums)
end
delete('/albums/sold/:id') do
  @album = Album.find_sold(params[:id].to_i())
  @album.delete_sold()
  @sold_albums = Album.sold()
  erb(:sold)
end
