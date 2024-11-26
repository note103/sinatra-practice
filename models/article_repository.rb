# frozen_string_literal: true

class ArticleRepository
  FILE_PATH = 'articles.json'

  def self.all
    return [] unless File.exist?(FILE_PATH)

    JSON.parse(File.read(FILE_PATH))
  end

  def self.find(id)
    all.find { |article| article['id'] == id }
  end

  def self.save(articles)
    File.write(FILE_PATH, articles.to_json)
  end

  def self.add(article)
    articles = all
    articles << article
    save(articles)
  end

  def self.update(id, attributes)
    articles = all
    article = articles.find { |a| a['id'] == id }
    return unless article

    article.merge!(attributes)
    save(articles)
  end

  def self.delete(id)
    articles = all.reject { |article| article['id'] == id }
    save(articles)
  end
end
