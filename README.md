# メモアプリ

Sinatra で作られたシンプルなメモアプリです。

## Requirements

このアプリは以下の環境で動作確認をしています。

- macOS
- Ruby 3.3.6
- Bundler 2.5.23
- PostgreSQL 14.15
- Git

## Installation

アプリのインストール方法は以下のとおりです。

1. リポジトリを clone します。

```bash
git clone https://github.com/note103/sinatra-practice.git
cd sinatra-practice
```

2. Bundler を使って Gem をインストールします。

Bundler がインストールされていない場合は、事前にインストールしてください。

```bash
gem install bundler
```

Bundler で Gem をインストールします。

```bash
bundle install
```

## Database Setup

このアプリは、PostgreSQL を使用してデータを保存します。以下の手順でデータベースをセットアップしてください。

1. PostgreSQL をインストールします。macOS で Homebrew を使用する場合は以下のコマンドでインストールしてください。

```bash
brew install postgresql
```

その他、OSに応じたインストール方法は[PostgreSQL公式サイト](https://www.postgresql.org/)を参照してください。

2. ターミナルでデータベースを作成します。

```bash
createdb articles_db
```

3. テーブルを作成します。テーブル作成用のSQLスクリプトは `table_create.sql` に記載されています。以下のコマンドでスクリプトを実行してください。

```bash
psql -d articles_db -f table_create.sql
```

以下のSQLを直接入力してテーブルを作成しても構いません。

```sql
CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Usage

データベースの準備が完了したら、アプリを使用できます。アプリは以下のコマンドで実行します。

```bash
bundle exec ruby app.rb
```

サーバーが起動したら、ブラウザで [http://localhost:4567/](http://localhost:4567/) にアクセスして画面を確認してください。

停止する場合はターミナルで `Ctrl+C` を入力してください。

## Linter

コードの品質を保つために [RuboCop](https://github.com/rubocop/rubocop) と [ERB Lint](https://github.com/Shopify/erb-lint) を使用します。

以下の内容を Gemfile に追加してください。

```ruby
group :development do
  gem 'rubocop', require: false
  gem 'rubocop-fjord', require: false
  gem 'erb_lint', require: false
end
```

その後、以下のコマンドで Gem をインストールしてください。

```bash
bundle install
```

### Rubocop

Rubocop を使用するため、リポジトリのルートに `.rubocop.yml` を作成し、以下の内容を記述してください。

```yml
---
inherit_gem:
  rubocop-fjord:
    - "config/rubocop.yml"
```

RuboCop は以下のコマンドで実行します。

```bash
bundle exec rubocop
```

検出された問題を自動修正する場合は、以下のコマンドを実行します。

```bash
bundle exec rubocop --auto-correct
```

### ERB Lint

ERB Lint を使用するため、リポジトリのルートに `.erb_lint.yml` を作成し、以下の内容を記述してください。

```yml
---
glob: "**/*.erb"
linters:
  RequireInputAutocomplete:
    enabled: false
```

ERB Lint は以下のコマンドで実行します。

```bash
bundle exec erb_lint --lint-all
```

## License

このプロジェクトは [MIT ライセンス](https://opensource.org/license/MIT) のもとで公開されています。詳細は [LICENSE ファイル](./LICENSE) をご覧ください。
