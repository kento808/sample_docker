ご覧いただきありがとうございます。
開発環境
Ruby2.6.6
Ruby on Rails 6.0.3
ホストos: Macos
言語   : Ruby, HTML, CSS, Javascript, SQL
フレームワーク: Ryby on Rails
cssフレームワーク: bootstrap
jsライブラリ: jquery
インフラ: Docker, heroku, AWSS3
テストフレームワーク: Rspec
その他ツールなど: Devise, docker, Circleci, rubocop, Git, Github

[サイト内容]
沖縄の観光スポットを投稿し紹介するサイトです。

[実装機能]
Deviseを使った新規登録、ログイン機能等
ユーザーのプロフィール画面
プロフィール 編集機能
画像投稿機能
投稿詳細機能、投稿編集機能
検索機能
フォロー機能
コメント、いいね、通知機能
ページネーション
パスワード編集機能
Rspecでのテスト記述

[意識したこと]
フロントエンド
bootstrapを使い見やすいデザインになるようにしました。
バックエンド
・dry名コードになるよう意識しpartialファイルをできるだけ使い共通化するようにしました。
・rubocopを使いコードをチェックし修正して読みやすいコードを保つようにしました。
・Rspecを使い全てではありませんが、ほとんどの機能に関するテストを記述し動作をチェックしました。
