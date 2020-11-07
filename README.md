# cafe_appについて

## URL
https://oshicafe.com/

## サービス概要
- 岡山のお気に入りカフェを共有する投稿サイトです。
- ユーザーは投稿、お気に入り、コメントができます。

## 技術スタック
### バックエンド
- Ruby2.7.0
- Ruby on Rails6.0.3.3
- RSpec
- MySQL8.0.21
### フロントエンド
- HTML / CSS
- JavaScript / jQuery
### インフラ
#### AWS
 - ELB
 - VPC
 - EC2
 - Route53
 - S3
 - ACM
### バージョン管理
- Git

## サービスの機能一覧
- 投稿一覧、詳細機能
- 投稿作成、編集、削除機能
- 投稿する際にwifiの有無などを選択して表示する機能
- お気に入り機能
- コメント投稿、表示、削除機能
- ユーザー登録機能
- ユーザー情報編集機能
- ユーザー詳細機能
- ユーザー詳細ページに当該ユーザーの投稿、お気に入り投稿、コメントした投稿が表示される機能
- ログイン、ログアウト機能
- 簡単ログイン機能
- 画像ファイルのアップロード機能
- DBテーブルのリレーション機能
- ページネーション機能
- 単体テスト、統合テスト(RSpecを使用)

## 使用Gem
- CarrierWave
- MiniMagick
- Devise
- Kaminari
- Fog::Aws
- Capybara

## その他、使用技術・機能
- いいね機能、お気に入り機能の非同期通信
- プルリクを活用したGitHubフロー
- SSL化


