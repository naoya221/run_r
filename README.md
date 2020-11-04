# Run Record
#### ランナー向けのアプリケーションです。
ランニングコースの情報を共有したり、具体的な練習メニューを提示したりと、<br>
様々な機能にてランナーをサポート致します。<br>

# URL
https://runreco.com<br>
<br>
<img width="800" alt="スクリーンショット 2020-11-02 13 19 45" src="https://user-images.githubusercontent.com/68312425/97837982-9de42400-1d22-11eb-8c65-158899134d41.png"><br>
<br>

# なぜ作成したか
前職のランニングコーチの頃、紙ベースで練習メニューを作成し、お客様へお渡しする業務がありました。<br>
しかし人数が増えるにつれ、業務負荷がとても大きくなり、お客様自身がベストタイムを登録し、<br>
それを元に練習メニューが自動で作成されるアプリでもあればといいのにと考えておりました。<br>
当時の悩みを思い出し、プログラミングを学んだ現在、そのアプリケーションを形にしました。<br>
<br>
実際に前職のスタッフに使っていただき、フィードバックを元に改修した部分もございます。<br>
その話は是非、面接で熱くお話しさせていただきたく思っております！<br>

# 機能一覧
### ランニングコースの投稿機能
・お気に入りのランニングコース（コースの写真・名前、住所等）を投稿<br>
・投稿時の住所位置をGoogleMapにピン留め表示（geocoder）<br>
・タグ付け機能<br>
・投稿へのいいね機能（非同期通信）<br>
・投稿へのコメント機能（非同期通信）<br>
<br>
![画面収録 2020-11-02 15 23 00 mov](https://user-images.githubusercontent.com/68312425/97836489-c6b6ea00-1d1f-11eb-930d-3d92f1a676f2.gif)<br>
<br><br>

### ユーザー管理機能
・ユーザー情報の登録・編集<br>
・ユーザー同士のフォロー機能（非同期通信）<br>
・ベストタイム（5km、10km、ハーフ、フル）の登録・編集・削除<br>
・登録したベストタイムから、各距離の走力をグラフ化して表示<br>
・登録したベストタイムから、ランニング時の目安ペースを提示（練習メニュー例の中に表示しています）<br>
<br>
![画面収録 2020-11-02 15 29 26 mov](https://user-images.githubusercontent.com/68312425/97836768-552b6b80-1d20-11eb-9a3a-9df7c1c660b3.gif)<br>
<br><br>

### 走力・目安ペース一覧確認機能
・走力一覧ページにて、自分の該当する走力目安ペース部分をマーキング。<br>
<br>
![画面収録 2020-11-02 15 34 46 mov](https://user-images.githubusercontent.com/68312425/97837228-2366d480-1d21-11eb-947c-6cddd6298fd1.gif)<br>
<br><br>

### 通知機能
・お知らせページにて通知を確認できる。（いいね、コメント、フォロー時）<br>

### その他の機能・
・ランキング機能（投稿注目の人気コースにて、いいね数が多い順に表示）<br>
・ランニングコース投稿一覧の検索機能（タグ検索可）<br>
・ページネーション機能（kaminari）<br>
・画像投稿時のプレビュー機能<br>
・HTTPS通信(AWS Certificate Manager)<br>



# 環境・使用技術
### フロントエンド
・HTML/CSS<br>
・SCSS<br>
・JavaScript,　jQuery,　Vue.js<br>
・Bootstrap 4.5.0<br>

### バックエンド
・Ruby　2.6.5<br>
・Ruby on Rails　6.0.0<br>

### 開発環境
・MySQL2<br>
・Docker/Docker-compose<br>

### 本番環境
・AWS(ALB, EC2, S3, Route53, VPC)<br>
・Nginx<br>
・CircleCIにてDocker-composeよりコンテナを構築し、<br>
・Capistranoにより自動デプロイ<br>
・MariaDB<br>

### テスト
・Rspec (単体・結合　計167項目）<br>
・CircleCIにてDocker-composeよりコンテナを構築し、自動テスト<br>

### その他使用技術
・Google Maps API<br>
・非同期通信（投稿へのコメント・いいね、ユーザーのフォロー）<br>
・コードの自動修正（Rubocop）<br>
・GitHubの活用（プルリクエスト、マージ等）<br>

### インフラ構成図
<img width="566" alt="スクリーンショット 2020-09-25 11 20 01" src="https://user-images.githubusercontent.com/68312425/94219183-2e0f9c00-ff21-11ea-8f53-f6e1a52ff30b.png">

# 使用方法

### テスト用アカウント
「かんたんログイン」にてフォーム入力せずログインできます。<br>
　※確認者重複等でログインできない場合、以下のテストアカウントをお使いください<br>
　email:　a@a<br>
　password:　111111<br>

### お気に入りのランニングコースを投稿
・ヘッダーナビ、または追従ボタンの「かんたんログイン」より、ログインします。<br>
・「ランニングコースを投稿」をクリック<br>
・各項目を入力して「投稿」ボタンをクリックし、投稿が完了<br>
・＃ 投稿一覧（最新順）の一番上に入力した情報が表示される<br>
・ランニングコースの画像をクリック<br>
・先ほど入力した住所の位置がGoogleMapにピン留めされた状態で表示される<br>
　※このページにて投稿へのコメントができます。<br>
　※投稿のハートマークをクリックで「いいね」がされます。（投稿一覧・詳細ページどちらでも可能）<br>

### ベストタイム登録機能
・ヘッダーナビの「ユーザー名」をクリック。マイページへ<br>
・画面中部にある「登録」ボタンをクリック。（すでに登録済みの場合は「編集」をクリック）<br>
・ベストタイムをプルダウンより選択し、「登録」ボタンクリック。ベストタイムが登録される<br>
・登録されたタイムはマイページにて表示される<br>

### 走力・練習例の確認機能
・ベストタイムが登録されているユーザーのマイページにて、グラフ化された走力レベルを確認できる。<br>
・登録されているベストタイムの一段階上のタイムが「次はこの記録にチャレンジ！」下に表示される。<br>
・上記タイムを達成するための練習例を表示。（練習例内のペースはベストタイムによって変わります）<br>

### 走力・目安ペースの一覧確認機能
・ヘッダーナビの「走力一覧」をクリック。走力一覧・走力別の目安ペース一覧を確認できる。<br>
・ログインユーザーにベストタイムが登録されていれば、一覧内の該当箇所がマーキングされる。<br>
・他ユーザーのマイページより、「他ユーザー名の走力を一覧で確認」をクリック。<br>
　そのユーザーにベストタイムが登録されていれば、一覧内の該当箇所がマーキングされる<br>
　※ヘッダーナビの「走力一覧」をクリックすると、自分の該当箇所がマーキングされるので注意！<br>

# テーブル設計

### ER図
<img width="669" alt="スクリーンショット 2020-10-20 17 11 20" src="https://user-images.githubusercontent.com/68312425/96558948-607da080-12f7-11eb-915c-3de5f1929a99.png">
