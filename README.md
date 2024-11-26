# メモアプリ

Sinatra で作られたシンプルなメモアプリです。

## Requirements

このアプリは以下の環境で動作確認をしています。

- Ruby 3.3.6
- Bundler 2.5.23
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

## Usage

アプリは以下のコマンドで実行します。

```bash
bundle exec ruby app.rb
```

サーバーが起動したら、ブラウザで [http://localhost:4567/](http://localhost:4567/) にアクセスして画面を確認してください。

停止する場合はターミナルで `Ctrl+C` を入力してください。

## Linter

コードの品質を保つために [RuboCop](https://github.com/rubocop/rubocop) と [ERB Lint](https://github.com/Shopify/erb-lint) を使用します。

以下の内容を Gemfile に追加してください。

```bash
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

このプロジェクトは [MIT ライセンス](https://opensource.org/license/MIT) のもとで公開されています。詳細は [LICENSE](./LICENSE) ファイルをご覧ください。
