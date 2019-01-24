
require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :artist_id

  def initialize(options)
    @name = options['name']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO artists (name) Values ($1) RETURNING id"
      values = [@name]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = " UPDATE artists SET (
    name
    ) = (
      $1
      )
    WHERE id = $2"
    values = [@name, @artist_id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@artist_id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    order_hash = results.first
    order = Record.new(order_hash)
    return order
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    orders = SqlRunner.run(sql)
    return orders.map { |order| Record.new(order) }
  end



end
