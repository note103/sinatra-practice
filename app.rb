# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'models/article_repository'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

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

  if title.nil? || title.strip.empty?
    redirect '/articles/new'
  else
    article = { 'title' => title, 'body' => body }
    new_id = ArticleRepository.add(article)
    redirect "/articles/#{new_id}"
  end
end

# 編集ページ表示
get '/articles/:id/edit' do
  @article = ArticleRepository.find(params[:id].to_i)
  halt 404 unless @article
  erb :edit
end

# 記事編集
patch '/articles/:id' do
  title = params[:title]
  body = params[:body]
  article = ArticleRepository.find(params[:id].to_i)
  halt 404 unless article

  if title.nil? || title.strip.empty?
    redirect "/articles/#{params[:id]}/edit"
  else
    updated_article = { 'title' => title, 'body' => body }
    ArticleRepository.update(params[:id].to_i, updated_article)
    redirect '/articles'
  end
end

# 個別記事表示
get '/articles/:id' do
  @article = ArticleRepository.find(params[:id].to_i)
  halt 404 unless @article
  erb :show
end

# 記事削除
delete '/articles/:id' do
  ArticleRepository.delete(params[:id].to_i)
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
