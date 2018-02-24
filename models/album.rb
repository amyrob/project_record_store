require_relative('../db/sql_runner')

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

  def Album.delete
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

end #end of class
