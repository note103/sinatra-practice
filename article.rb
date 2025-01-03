# frozen_string_literal: true

require 'pg'

class Article
  DB_NAME = 'articles_db'

  def self.conn
    @conn ||= PG.connect(dbname: DB_NAME)
  end

  def self.prepare_statements
    conn.prepare('select_all', 'SELECT * FROM articles ORDER BY created_at ASC')
    conn.prepare('select_by_id', 'SELECT * FROM articles WHERE id = $1 LIMIT 1')
    conn.prepare('insert_article', 'INSERT INTO articles (title, body) VALUES ($1, $2) RETURNING id')
    conn.prepare('update_article', 'UPDATE articles SET title = $1, body = $2 WHERE id = $3')
    conn.prepare('delete_article', 'DELETE FROM articles WHERE id = $1')
  end

  # ハッシュのキーをシンボルに変換
  def self.sym_keys(hash)
    hash&.transform_keys(&:to_sym)
  end

  # 一覧取得
  def self.all
    result = conn.exec_prepared('select_all')
    result.map { |row| sym_keys(row) }.to_a
  end

  # 記事投稿
  def self.add(article)
    result = conn.exec_prepared(
      'insert_article',
      [article[:title], article[:body] || '']
    )
    sym_keys(result[0])[:id].to_i
  end

  # 特定の記事を取得
  def self.find(id)
    result = conn.exec_prepared('select_by_id', [id])
    return nil if result.num_tuples.zero?

    sym_keys(result[0])
  end

  # 記事編集
  def self.update(id, attributes)
    conn.exec_prepared(
      'update_article',
      [attributes[:title], attributes[:body] || '', id]
    )
  end

  # 記事削除
  def self.delete(id)
    conn.exec_prepared('delete_article', [id])
  end
end

Article.prepare_statements
