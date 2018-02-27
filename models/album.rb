require_relative('../db/sql_runner')
require_relative('artist')

class Album

  attr_reader :id
  attr_accessor :title, :quantity, :artist_id, :buy_price, :sell_price

  def initialize (options)
    @id = options['id'].to_i
    @title = options['title']
    @quantity = options['quantity']
    @artist_id = options['artist_id'].to_i
    @buy_price = options['buy_price'].to_i
    @sell_price = options['sell_price'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, quantity, artist_id, buy_price, sell_price)
    VALUES ($1, $2, $3, $4, $5) RETURNING *;"

    values = [@title, @quantity, @artist_id, @buy_price, @sell_price]
    album = SqlRunner.run(sql, values).first
    @id = album['id'].to_i
  end

  def delete()
    sql = "DELETE FROM albums
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE albums SET (quantity, buy_price, sell_price)
    = ($1, $2, $3) WHERE id = $4;"

    values = [@quantity, @buy_price, @sell_price, @id]
    SqlRunner.run(sql, values)
  end

  def stock_level()
    if @quantity.to_i <= 5
      return "Low"
    elsif @quantity.to_i <= 10
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

  def profit()
    return @sell_price - @buy_price
  end

  def Album.delete
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def Album.find(id)
    sql = "SELECT * FROM albums
    WHERE id = $1"
    values = [id]
    album = SqlRunner.run(sql, values)
    outcome = Album.new(album.first)
    return outcome
  end

  def Album.all
    sql = "SELECT * FROM albums;"
    all_albums = SqlRunner.run(sql)
    return all_albums.map { |album| Album.new(album)}
  end

end #end of class
