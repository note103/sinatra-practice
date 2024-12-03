# frozen_string_literal: true

class Article
  attr_accessor :id, :title, :body

  def initialize(title:, body:, id: nil)
    @id = id
    @title = title
    @body = body
  end

  def save
    if id.nil?
      @id = ArticleRepository.add(self)
    else
      ArticleRepository.update(id, { title: title, body: body })
    end
  end

  def self.find(id)
    ArticleRepository.find(id)
  end
end
