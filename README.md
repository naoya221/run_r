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

# 概要
気晴らしや適度な運動習慣でランニングを楽しむ方から、競技思考の方まで<br>
様々な目的を持つランナーをサポートするサービスです。<br>
PC、スマートフォンどちらでもお使い頂けます。<br>
<br>

# URL
http://54.150.90.255/<br>
<br>

# テスト用アカウント
Email　　 ：a@a<br>
<br>
password ：111111<br>
<br>

# 機能一覧

### ランニングコースの投稿機能
・お気に入りのランニングコース（写真、住所、簡単な説明文）を投稿・編集・削除<br>
<br>
・GoogleMapに投稿時の住所位置をピン留め表示<br>
<br>
・非同期通信でのコメント機能<br>
<br>

### ユーザー管理機能
・ユーザー情報の登録・編集・削除<br>
・ベストタイム（5km、10km、ハーフ、フル）の登録・編集・削除（<br>
<br>

### 走力・ランニングペース確認機能
・登録したベストタイムから、各距離の得意不得意をグラフ化して表示。<br>
<br>
・登録したベストタイムから、ランニングのペースを目的別に4種類表示。<br>
<br>
・距離別の走力レベル表、走力別のランニングペース表の一覧を表示<br>
<br>
・専門用語に対する説明文の表示<br>
<br>

### その他
・レスポンシブデザイン<br>
<br>
・ページネーション機能<br>
<br>
・画像投稿時のプレビュー機能<br>
<br>












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