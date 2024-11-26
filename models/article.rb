# frozen_string_literal: true

class Article
  attr_reader :id, :title, :body

  def initialize(id:, title:, body:)
    @id = id
    @title = title
    @body = body
  end

  def save
    ArticleRepository.add(to_h)
  end

  def to_h
    { 'id' => id, 'title' => title, 'body' => body }
  end

  def self.find(id)
    data = ArticleRepository.find(id)
    return nil unless data

    new(**data)
  end
end
