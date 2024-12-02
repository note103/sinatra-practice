# frozen_string_literal: true

require 'pg'

class ArticleRepository
  DB_NAME = 'articles_db'

  def self.all
    connection = PG.connect(dbname: DB_NAME)
    result = connection.exec('SELECT * FROM articles ORDER BY created_at ASC')
    connection.close
    result.map { |row| row }
  end

  def self.find(id)
    connection = PG.connect(dbname: DB_NAME)
    result = connection.exec_params('SELECT * FROM articles WHERE id = $1 LIMIT 1', [id])
    connection.close
    result.ntuples == 1 ? result[0] : nil
  end

  def self.add(article)
    connection = PG.connect(dbname: DB_NAME)
    connection.exec_params(
      'INSERT INTO articles (title, body, created_at) VALUES ($1, $2, NOW())',
      [article['title'], article['body'] || '']
    )
    connection.close
  end

  def self.update(id, attributes)
    connection = PG.connect(dbname: DB_NAME)
    connection.exec_params(
      'UPDATE articles SET title = $1, body = $2 WHERE id = $3',
      [attributes['title'], attributes['body'] || '', id]
    )
    connection.close
  end

  def self.delete(id)
    connection = PG.connect(dbname: DB_NAME)
    connection.exec_params('DELETE FROM articles WHERE id = $1', [id])
    connection.close
  end
end
