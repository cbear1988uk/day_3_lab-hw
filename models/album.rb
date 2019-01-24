
require_relative('../db/sql_runner')

class Album

  attr_accessor :name, :genre
  attr_reader :album_id

  def initialize(options)
    @name = options['name']
    @genre = options['genre']
    @album_id = options['id'].to_i 
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO albums (
    name,
    genre
    ) Values (
      $1, $2
      )
      RETURNING id"
      values = [@name, @genre]
      @album_id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = " UPDATE albums SET (
    name,
    genre
    ) = (
      $1, $2
      )
    WHERE id = $3"
    values = [@name, @genre, @album_id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@album_id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    order_hash = results.first
    order = Record.new(order_hash)
    return order
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    orders = SqlRunner.run(sql)
    return orders.map { |order| Record.new(order) }
  end



end
