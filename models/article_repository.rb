# frozen_string_literal: true

require 'pg'

class ArticleRepository
  DB_NAME = 'articles_db'

  def self.connection
    @connection ||= PG.connect(dbname: DB_NAME)
  end

  def self.prepare_statements
    connection.prepare('select_all', 'SELECT * FROM articles ORDER BY created_at ASC')
    connection.prepare('select_by_id', 'SELECT * FROM articles WHERE id = $1 LIMIT 1')
    connection.prepare('insert_article', 'INSERT INTO articles (title, body, created_at) VALUES ($1, $2, NOW())')
    connection.prepare('update_article', 'UPDATE articles SET title = $1, body = $2 WHERE id = $3')
    connection.prepare('delete_article', 'DELETE FROM articles WHERE id = $1')
  end

  def self.all
    result = connection.exec_prepared('select_all')
    result.map { |row| row }
  end

  def self.find(id)
    result = connection.exec_prepared('select_by_id', [id])
    result.ntuples == 1 ? result[0] : nil
  end

  def self.add(article)
    connection.exec_prepared('insert_article', [article['title'], article['body'] || ''])
  end

  def self.update(id, attributes)
    connection.exec_prepared('update_article', [attributes['title'], attributes['body'] || '', id])
  end

  def self.delete(id)
    connection.exec_prepared('delete_article', [id])
  end
end

ArticleRepository.prepare_statements
