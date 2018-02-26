require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize (options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name)
    VALUES ($1) RETURNING *;"

    values = [@name]
    artist = SqlRunner.run(sql, values).first
    @id = artist['id'].to_i
  end


  def Artist.delete
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def Artist.all
    sql = "SELECT * FROM artists;"
    all_artists = SqlRunner.run(sql)
    return all_artists.map { |artist| Artist.new(artist)}
  end

  end #end of class
