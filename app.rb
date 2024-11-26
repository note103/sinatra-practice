# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require_relative 'models/article_repository'

ARTICLES = 'articles.json'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def load_articles
    if File.exist?(ARTICLES)
      JSON.parse(File.read(ARTICLES))
    else
      []
    end
  end

  def save_articles(articles)
    File.write(ARTICLES, articles.to_json)
  end

  # 改行の整形
  def format_text(text)
    h(text).gsub("\n", '<br>')
  end
end

# 一覧表示
get '/articles' do
  @articles = ArticleRepository.all
  erb :index
end

# 投稿ページ表示
get '/articles/new' do
  erb :new
end

# 記事投稿
post '/articles' do
  title = params[:title]
  body = params[:body]
  if title && !title.empty?
    article = { 'id' => SecureRandom.uuid, 'title' => title, 'body' => body }
    ArticleRepository.add(article)
  end
  redirect '/articles'
end

# 編集ページ表示
get '/articles/:id/edit' do
  @article = load_articles.find { |article| article['id'] == params[:id] }
  halt 404 unless @article
  erb :edit
end

# 記事編集
patch '/articles/:id' do
  title = params[:title]
  body = params[:body]
  articles = load_articles
  article = articles.find { |a| a['id'] == params[:id] }
  halt 404 unless article

  if title && !title.empty?
    article['title'] = title
    article['body'] = body
    save_articles(articles)
  end
  redirect "/articles/#{params[:id]}"
end

# 個別記事表示
get '/articles/:id' do
  @article = load_articles.find { |article| article['id'] == params[:id] }
  halt 404 unless @article
  erb :show
end

# 記事削除
delete '/articles/:id' do
  articles = load_articles
  articles.reject! { |article| article['id'] == params[:id] }
  save_articles(articles)
  redirect '/articles'
end

# 404エラー
not_found do
  erb :not_found
end

# ルートページのリダイレクト
get '/' do
  redirect '/articles'
end
