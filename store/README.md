# Store - 在庫通知システム

Rails 8で構築された在庫管理・通知システムです。商品の在庫状況を管理し、在庫切れ商品の入荷時に登録ユーザーへ自動通知を行います。

## 主な機能

- 商品管理（画像、リッチテキストによる説明）
- 在庫数の追跡
- 在庫切れ商品の入荷通知
- ユーザー認証
- 多言語対応（英語・スペイン語）

## 技術スタック

- Ruby on Rails 8.0.1
- Hotwire (Turbo, Stimulus)
- SQLite3
- Active Storage（画像管理）
- Action Text（リッチテキスト）
- Active Job（非同期処理）

## 開発環境

### VS Code設定

以下の拡張機能をインストールすることを推奨します：

- Ruby LSP：コード補完、定義ジャンプなどの機能を提供
- Ruby Test Explorer：テストの実行と結果の表示
- ERB Formatter/Beautify：ERBテンプレートの整形

`.vscode/settings.json`の推奨設定：

```json
{
  "ruby.lint": {
    "rubocop": true
  },
  "ruby.format": "rubocop",
  "ruby.intellisense": "rubyLocate",
  "ruby.lsp.enabled": true
}
```

## セットアップ

```bash
# リポジトリのクローン
git clone [repository-url]

# 依存関係のインストール
bundle install

# データベースのセットアップ
rails db:create
rails db:migrate

# 開発サーバーの起動
bin/dev
```

## デプロイ

Dockerコンテナーとして、Kamalを使用してどこにでもデプロイ可能です。

```bash
kamal deploy
```

## テスト

システムテスト、ユニットテスト、メーラーテストが実装されています：

```bash
rails test
