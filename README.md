# Oshicafe@okayama
転職活動用に作成したポートフォリオアプリです。</br>
Ruby on Rails(ver. 6.0.3)を用いて、岡山のノマドカフェを共有する投稿サイトを作成しました。</br>
シンプルで使いやすく、またノマドワーカーにとって知りたい情報（wifiや電源の有無など）が一目で分かるサービスになるよう、工夫しました。</br>
レビューを受け、改善作業を引き続き行っております。

## 本番環境 URL
https://oshicafe.com/

## ワイヤーフレーム
https://xd.adobe.com/view/122096fb-4482-4a82-97bf-5643810493a4-4773/

<img width="1355" alt="スクリーンショット 2020-11-25 20 21 58" src="https://user-images.githubusercontent.com/55953263/100221360-ec6c9300-2f5b-11eb-9db8-19cac9f44bbf.png">

## ER図
<img width="462" alt="スクリーンショット 2020-11-25 20 16 19" src="https://user-images.githubusercontent.com/55953263/100220737-1bced000-2f5b-11eb-8213-d5ed570fbf82.png">
![image](https://user-images.githubusercontent.com/55953263/102451114-3dfbcf80-407b-11eb-8c93-b2b1eb17af37.png)

## サービス概要
- 岡山のノマドカフェを共有する投稿サイトです。
- 新規登録の他に、ヘッダーの「簡単ログイン」から、ゲストユーザーアカウントによる利用も可能です。
- ユーザーは投稿、お気に入り、コメントができます。
- 投稿する際は、wifiや電源の有無、クレジットカードや電子マネーが利用可能かどうかを選択できます。
- 投稿する際、画像ファイルを選択しない場合は、デフォルト画像が表示されます。
- 各投稿に付しているマークで、wifiや電源の有無、クレジットカードが利用可能かどうかを確認できます。

### 使い方の一例
- 簡単ログイン後、お気に入り、コメント投稿、コメント削除
![sample](https://user-images.githubusercontent.com/55953263/101269318-3140c700-37b1-11eb-911f-1e6910697c8d.gif)

- ログイン後、投稿、編集</br>
![sample2](https://user-images.githubusercontent.com/55953263/101270686-c72f1e80-37be-11eb-8a92-68a9254af563.gif)

## 制作の背景
夫の転勤に伴い、現在岡山在住。</br>
引越し当初、プログラミングの勉強のためノマドカフェを探していましたが、</br>
wifiがあり、かつ長時間作業可能なお気に入りのカフェを見つけるのに苦労しました。</br>
そこで、岡山のノマドカフェを共有する投稿サイトがあればいいなと考え、作成しました。

## ポートフォリオ作成で意識した点
- 実際のチーム開発を意識し、GitHubのIssueやプルリクを活用
- パフォーマンスを上げることを意識し、N+1問題を対策
- 特にセキュリティ上重要なところや、重要度の高いユースケースで不具合を生じさせないよう、単体テスト/統合テストを実装（RSpec）
- 実際の現場でも対応できるようにするため、インフラにはHerokuではなくAWSを使用
- 綺麗なコードを書く習慣を身に付けるため、Rubocop導入

## 技術スタック
### バックエンド
- Ruby2.7.0
- Ruby on Rails6.0.3
- RSpec
- MySQL8.0
### フロントエンド
- HTML / CSS
- JavaScript / jQuery
### インフラ
- AWS
    - ELB
    - VPC
    - EC2
    - Route53
    - S3
    - ACM
### バージョン管理
- Git
### その他、使用技術
- Bootstrap使用
- 一部Ajax使用
- Rubocop設定
- Issueやプルリクを活用したGitHubフロー
- SSL化
- N+1問題

## サービスの機能一覧
- 投稿一覧/詳細機能
- 投稿作成/編集/削除機能
- 投稿する際にwifiや電源の有無などを選択して表示する機能
- お気に入り機能
- コメント投稿/表示/削除機能（削除の際、確認ダイアログ表示）
- ユーザー登録/退会機能（退会の際、確認ダイアログ表示）
- ユーザー情報編集機能
- ユーザー詳細機能
- ユーザー詳細ページに当該ユーザーの投稿/お気に入り投稿/コメントした投稿が表示される機能
- ログイン/ログアウト機能
- 簡単ログイン機能
- 画像ファイルのアップロード機能
- DBテーブルのリレーション機能
- ページネーション機能
- 単体テスト/統合テスト(RSpecを使用)

### その他の機能
- お気に入り機能/コメント機能の非同期通信

## 主な使用Gem
- CarrierWave
- MiniMagick
- Devise
- Kaminari
- Fog::Aws
- Capybara
- Bullet


