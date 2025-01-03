# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'article'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  # 改行の整形
  def format_text(text)
    h(text).gsub("\n", '<br>')
  end

  # idが整数かチェック
  def valid_id?(id)
    id.to_s.match?(/\A\d+\z/)
  end
end

# 一覧表示
get '/articles' do
  @articles = Article.all
  erb :index
end

# 投稿ページ表示
get '/articles/new' do
  erb :new
end

# 記事投稿
post '/articles' do
  title = params[:title].strip
  body = params[:body].strip

  if title.nil? || title.empty?
    redirect '/articles/new'
  else
    article = { title: title, body: body }
    new_id = Article.add(article)
    redirect "/articles/#{new_id}"
  end
end

# 編集ページ表示
get '/articles/:id/edit' do
  halt 404 unless valid_id?(params[:id])

  @article = Article.find(params[:id].to_i)
  halt 404 unless @article
  erb :edit
end

# 記事編集
patch '/articles/:id' do
  article = Article.find(params[:id].to_i)
  article[:title] = params[:title].strip
  article[:body] = params[:body].strip
  Article.update(article[:id], { title: article[:title], body: article[:body] })
  redirect "/articles/#{article[:id]}"
end

# 個別記事表示
get '/articles/:id' do
  halt 404 unless valid_id?(params[:id])

  @article = Article.find(params[:id].to_i)
  halt 404 unless @article
  erb :show
end

# 記事削除
delete '/articles/:id' do
  Article.delete(params[:id].to_i)
  redirect '/articles'
end

not_found do
  erb :not_found
end

get '/' do
  redirect '/articles'
end
