require "sinatra"
require "sinatra/reloader" if development?
require "sqlite3"

DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/jukebox.sqlite'))

get "/" do
  # TODO: Gather all artists to be displayed on home page
  @artists = DB.execute("SELECT name, id FROM artists").sort
  erb :home # Will render views/home.erb file (embedded in layout.erb)
end

# Then:
# 1. Create an artist page with all the albums. Display genres as well
get '/artists/:id' do
  # display all albums for this id
  @albums = DB.execute("SELECT * FROM albums WHERE artist_id = #{params[:id]}")
  erb :artists
end

# 2. Create an album pages with all the tracks
get '/albums/:id' do
  @tracks = DB.execute("SELECT name, id FROM tracks WHERE album_id = #{params[:id]}")
  erb :albums
end

# 3. Create a track page with all the track info
get '/tracks/:id' do
  @infos = DB.execute("SELECT * FROM tracks WHERE id = #{params[:id]}")
  erb :tracks
end
