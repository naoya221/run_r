# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Run Record
<br>
<br>
# 概要<br>
<br>
気晴らしや適度な運動習慣でランニングを楽しむ方から、競技思考の方まで<br>
様々な目的を持つランナーをサポートするサービスです。<br>
PC、スマートフォンどちらでもお使い頂けます。<br>
<br>
<br>
# URL<br>
http://54.150.90.255/<br>
<br>
<br>
テスト用アカウント<br>
<br>
Email：a@a<br>
password：111111<br>
<br>
<br>
# 機能一覧<br>
<br>
## ランニングコースの投稿機能<br>
・お気に入りのランニングコース（写真、住所、簡単な説明文）を投稿・編集・削除<br>
・GoogleMapに投稿時の住所位置をピン留め表示<br>
・非同期通信でのコメント機能<br>
<br>
## ユーザー管理機能<br>
・ユーザー情報の登録・編集・削除
・ベストタイムの（5km、10km、ハーフ、フル）登録・編集・削除（<br>
<br>
<br>
## 走力・ランニングペース確認機能
・登録したベストタイムから、各距離の得意不得意をグラフ化して表示。<br>
・登録したベストタイムから、ランニングのペースを目的別に4種類表示。<br>
・距離別の走力レベル表、走力別のランニングペース表の一覧を表示<br>
.専門用語に対する説明文の表示<br>
<br>
<br>
## その他<br>
・レスポンシブデザイン<br>
<br>
・ページネーション機能<br>
<br>
・画像投稿時のプレビュー機能<br>
<br>





概要
「ノミカイの準備を楽しく、便利に」

幹事さんと参加者双方に向けた、飲み会の準備を楽しく便利にサポートするサービスです。

URL
https://nomi-joy.com

【かんたんログイン】ボタンからテストユーザーとしてログインできます。 幹事側へは、参加者側からログイン後「カンジの部屋」のロゴマークから入室できます。

制作の背景
前職で会社の飲み会の幹事をすることがありましたが、出欠や会費徴収の管理が大変でした。

特に、送別会のシーズンになると飲み会が月に何件も重なり、「どの飲み会をどこまで準備できているんだっけ？」「○○さんからこの前の会費をまだいただいてないけど目上の方だから何度もお願いしにくいな・・・」「○○さんが欠席したのはどの飲み会だったっけ？」などと混乱してしまうことがありました。

幹事をしてこのように大変な経験をした人は多いはず・・・そのような人たちが少しでも「便利にかつ楽しく」飲み会の準備をできたら、という思いからこのサービスを制作しました。同時に、参加者の方にとっても便利に利用できるサービスを目指しました。

主な利用シーン
飲み会の準備期間中〜集金完了まで

【幹事側】

会社の飲み会（中〜大人数規模）の幹事として、決定事項の記録、参加者への情報共有、会費の集金管理をしたいとき
幹事をする飲み会が多数あり、それぞれの進捗管理を行いたいとき
【参加者側】

飲み会の情報（場所、会費など）を確認したいとき
幹事に連絡をしたいとき（欠席や遅刻の連絡など）
機能一覧
通知機能
フォローされた時、DMが届いた時、飲み会に招待された時、飲み会のリマインドが届いた時、幹事が支払い依頼ボタンを押した時、幹事に会費を領収された時に通知が来る
メール機能
飲み会に招待された時、飲み会のリマインドが届いた時、幹事が支払い依頼ボタンを押した時、幹事に会費を領収された時、未読通知3件以上溜まったとき、参加する飲み会の前日にメール送信
定時処理
未読通知が3件以上溜まったユーザーに毎日午前８時にメール送信、飲み会の前日午前８時に参加者全員にメール・通知送信
DM機能
ToDoリスト
検索機能 （ぐるなびAPIを使用し店舗検索、保存）
マップ表示 （ぐるなびAPIにて取得した住所から表示）
カレンダー表示(保存した飲み会情報を表示)
マッチング（フォロー）機能
レスポンシブデザイン








# テーブル設計


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








<!-- # テーブル設計 -->

## users テーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| nickname              | string  | null: false |
| email                 | string  | null: false |
| password              | string  | null: false |
| password_confirmation | string  | null: false |
| family_name           | string  | null: false |
| first_name            | string  | null: false |
| family_name_kana      | string  | null: false |
| first_name_kana       | string  | null: false |
| birthday              | date    | null: false |


### Association

- has_many :items
- has_many :buys

## items テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null: false                   |
| content            | text       | null: false                   |
| category_id        | integer    | null: false                   | 
| condition_id       | integer    | null: false                   |
| delivery_fee_id    | integer    | null: false                   |
| prefecture_id      | integer    | null: false                   |
| days_until_ship_id | integer    | null: false                   |
| price              | integer    | null: false                   |
| user               | references | null: false, foreign_key:true |
| sall               | boolean    | default: false                |

### Association

- belongs_to :user
- has_one :address
- has_one :buy

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |   
| city          | string     | null: false                    |
| address_name  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | integer    | null: false                    |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :item

## buys テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| item     | references | null: false, foreign_key: true |
| user     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item