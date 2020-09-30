require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
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

  # Get the detail for a specific song such as lyrics and songwriters.
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end


post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil)
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

