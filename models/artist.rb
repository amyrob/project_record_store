require_relative('../db/sql_runner')

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

end #end of class
