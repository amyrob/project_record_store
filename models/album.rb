require_relative('../db/sql_runner')
require_relative('artist')

class Album

  attr_reader :id
  attr_accessor :title, :quantity, :artist_id

  def initialize (options)
    @id = options['id'].to_i
    @title = options['title']
    @quantity = options['quantity']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, quantity, artist_id)
    VALUES ($1, $2, $3) RETURNING *;"

    values = [@title, @quantity, @artist_id]
    album = SqlRunner.run(sql, values).first
    @id = album['id'].to_i
  end

  def stock_level()
    if @quantity.to_i <= 5
      return "Low"
    end
      if @quantity.to_i <= 10
        return "Medium"
      else
        return "High"
      end
    end

    def artist()
        sql = "SELECT * FROM artists
        WHERE artists.id = $1"
        values = [@artist_id]
        artist_name = SqlRunner.run(sql, values)
        new_artist = artist_name.map {|artist| Artist.new(artist)}.first
        return new_artist.name
      end

    def Album.delete
      sql = "DELETE FROM albums;"
      SqlRunner.run(sql)
    end

    def Album.all
      sql = "SELECT * FROM albums;"
      all_albums = SqlRunner.run(sql)
      return all_albums.map { |album| Album.new(album)}
    end

  end #end of class
