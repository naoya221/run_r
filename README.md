# 概要
「Run Record」<br>
気晴らしや適度な運動習慣でランニングを楽しむ方から、競技思考の方まで様々な目的を持つ<br>
ランナーをサポートするサービスです。PC、スマートフォンどちらでもお使い頂けます。<br>

# URL
https://runreco.com/<br>

# 目指した課題解決
ランニングは手軽に始めることができる反面、飽きやすく続けられないという声をよく耳にします。<br>
気になったコースを走ってみて、単調なランニングに刺激を与える！<br>
ダイエットや走力向上など、目的に沿った最適な練習ペースを提示し、よりよい結果を出していただく！<br>
こういった形でランニングに対する楽しさを感じたり、モチベーションの維持に役立てていただければと思います。<br>

# 機能一覧

### ランニングコースの投稿機能
・お気に入りのランニングコース（写真、住所、簡単な説明文）を投稿・編集・削除<br>
・GoogleMapに投稿時の住所位置をピン留め表示<br>
・非同期通信でのコメント機能（Action Cable）<br>

### ユーザー管理機能
・ユーザー情報の登録・編集<br>
・ベストタイム（5km、10km、ハーフ、フル）の登録・編集・削除<br>

### 走力・ランニングペース確認機能
・登録したベストタイムから、各距離の得意不得意をグラフ化して表示<br>
・登録したベストタイムから、ランニング時の推奨ぺースを目的別に4種類表示<br>
・距離別の走力レベル表、走力別の推奨ペース表の一覧を表示<br>
・専門用語に対する説明文の表示<br>

### その他の機能
・レスポンシブデザイン<br>
・ランニングコース投稿一覧の検索機能<br>
・ページネーション機能（kaminari）<br>
・画像投稿時のプレビュー機能(素のJavaScriptのみで実装)<br>
・HTTPS通信(AWS Certificate Manager)<br>


# 環境・使用技術
### フロントエンド
・HTML/CSS<br>
・SCSS<br>
・JavaScript,　jQuery<br>
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
　Capistranoにより自動デプロイ<br>
・MySQL2<br>

### テスト
・Rspec (単体・結合）<br>
・CircleCIにてDocker-composeよりコンテナを構築し、自動テスト<br>

### インフラ構成図
<img width="566" alt="スクリーンショット 2020-09-25 11 20 01" src="https://user-images.githubusercontent.com/68312425/94219183-2e0f9c00-ff21-11ea-8f53-f6e1a52ff30b.png">

# 使用方法

### テスト用アカウント
「かんたんログイン」にてフォーム入力せずログインできます。<br>
　※確認者重複等でログインできない場合、以下のテストアカウントをお使いください<br>
　email:　a@a<br>
　password:　111111<br>

### お気に入りのランニングコースを投稿
・ヘッダーナビの「かんたんログイン」より、ログインします。<br>
・「お気に入りコースをシェアしよう」をクリック<br>
・各項目を入力して「投稿」ボタンをクリックし、投稿が完了<br>
・投稿一覧の一番上に入力した情報が表示される<br>
・ランニングコースの画像をクリック<br>
・先ほど入力した住所の位置がGoogleMapにピン留めされた状態で表示される<br>

### ベストタイム登録機能
・ヘッダーナビの「ユーザー名：さん」をクリック。マイページへ<br>
・画面中部にある登録ボタンをクリック<br>
・ベストタイムをプルダウンより選択し、「登録」ボタンクリック。ベストタイムが登録される<br>
・登録されたタイムはマイページにて表示される<br>

### 走力・ランニングペース確認機能
・ベストタイムが登録されているユーザーのプロフィール画像（投稿一覧等から）をクリック<br>
・クリックしたユーザーのマイページへ遷移するので、画面中部の「練習」ボタンをクリック<br>
・画面最上部にグラフが表示されている（左から5km、10km、ハーフ、フル）<br>
・グラフの位置が上にある程、その距離の走力レベルが高い（距離別の得意不得意が確認できる）<br>
・グラフのすぐ下に、距離別の走力レベル表、走力別の推奨ペースを合わせて表示<br>
・さらにその下には走力レベル表・推奨ペース表の一覧を全て表示<br>

# テーブル設計

### ER図
<img width="519" alt="スクリーンショット 2020-09-11 14 42 31" src="https://user-images.githubusercontent.com/68312425/92868877-2c33dc00-f43d-11ea-9eb3-13648370f155.png">

## users テーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| nickname              | string  | null: false |
| email                 | string  | null: false |
| password              | string  | null: false |
| password_confirmation | string  | null: false |
| image                 | string  | null: false |

### Association

- has_many :tweets
- has_many :messages
- has_one :five_km_record
- has_one :ten_km_record
- has_one :half_record
- has_one :full_record


## tweets テーブル

| Column      | Type       | Options                       |
| ----------- | ---------- | ----------------------------- |
| content     | string     | null: false                   |
| address     | string     | null: false                   |
| latitude    | float      |                               |
| longitude   | float      |                               |
| place_name  | string     | null: false                   |
| place_image | string     | null: false                   |
| user        | references | null: false, foreign_key:true |

### Association

- belongs_to :user
- has_many :messages,  dependent: :destroy


## messages テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| text     | text       |                                |
| user     | references | null: false, foreign_key: true |
| tweet    | references | null: false, foreign_key: true |

### Association

- belongs_to :tweet
- belongs_to :user


## five_km_records テーブル

| Column    | Type       | Options                       |
| --------- | ---------- | ----------------------------- |
| minute_id | integer    | null: false                   |
| second_id | integer    | null: false                   |
| user      | references | null: false, foreign_key:true |

### Association

- belongs_to_active_hash :minute
- belongs_to_active_hash :second
- belongs_to :user


## ten_km_records テーブル

| Column    | Type       | Options                       |
| --------- | ---------- | ----------------------------- |
| minute_id | integer    | null: false                   |
| second_id | integer    | null: false                   |
| user      | references | null: false, foreign_key:true |

### Association

- belongs_to_active_hash :minute
- belongs_to_active_hash :second
- belongs_to :user


## half_records テーブル

| Column    | Type       | Options                       |
| --------- | ---------- | ----------------------------- |
| hour_id   | integer    | null: false                   |
| minute_id | integer    | null: false                   |
| second_id | integer    | null: false                   |
| user      | references | null: false, foreign_key:true |

### Association

- belongs_to_active_hash :hour
- belongs_to_active_hash :minute
- belongs_to_active_hash :second
- belongs_to :user


## full_records テーブル

| Column    | Type       | Options                       |
| --------- | ---------- | ----------------------------- |
| hour_id   | integer    | null: false                   |
| minute_id | integer    | null: false                   |
| second_id | integer    | null: false                   |
| user      | references | null: false, foreign_key:true |

### Association

- belongs_to_active_hash :hour
- belongs_to_active_hash :minute
- belongs_to_active_hash :second
- belongs_to :user
