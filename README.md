
# 概要

- このレポジトリでは[Rails 8のチュートリアル](https://guides.rubyonrails.org/getting_started.html)を実施した。
- 開発環境には、VS CodeのDevContainerを次の設定で利用した。
  - DevContainerで利用するディストリビューションはDebian 12 "Bookworm"ベースとした。
    - DevContainer内でのGitコミットにSSH鍵で署名したかったが、それをするためGit 2.34以降が必要であり、Debian 11 (Bullseye)を利用するとSSH署名に対応していないGit 2.30になってしまうため。
  - DevContainerのテンプレートは[Ruby on Rails & Postgres](https://github.com/devcontainers/templates/tree/main/src/ruby-rails-postgres)を利用した
    - ただし、Rails 8からはDBはSQLite3でまかなえるようになったので、チュートリアルを実施するだけであればPostgreSQLは不要であった。
- VS Codeの拡張機能では[Ruby LSP](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-lsp)を入れ、コードジャンプなどができるようにした。また、[ruby-lspを少し便利にするruby-lsp-addons](https://tech.enigmo.co.jp/entry/2024/12/10/070000)を参考に[ruby-lsp-rails Gem](https://github.com/Shopify/ruby-lsp-rails)を入れることでRails固有のDSLに対応したり、ControllerからViewにジャンプできるようにした。
- VS CodeのTest ExplorerでRailsのテストケースの表示や実行が行えるようにするため、[Ruby Test Explorer](https://marketplace.visualstudio.com/items?itemName=connorshea.vscode-ruby-test-adapter)の拡張機能を入れた。
  - [Ruby Test ExplorerはサブフォルダーにRailsのプロジェクトがある場合に上手くテストケースを見つけてくれない不具合](https://github.com/connorshea/vscode-ruby-test-adapter/issues/123)があるようだったので、VS CodeをMulti-root Workspaces構成にして問題を回避した。
