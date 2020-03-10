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
# name
  matching-app
# Overview
  マッチングアプリ。互いにいいねを送り合ったユーザー同士はメッセージでやりとりができる。


# matching-app DB設計
## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index:true|
|avatar|string|null: false|
|gender|integer|null: false|
|town|string|null: false|
|comment|remarks|null: false|

### Association
- has_many :messages, dependent: :destroy
- has_many :entries, dependent: :destroy

## roomsテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user｜refarence|null: false|

### Association
- has_many :messages, dependent: :destroy
- has_many :entries, dependent: :destroy

## messagesテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|body|text|null: false|
|image|string|null: false|
|user_id|references|null: false, foreign_key: true|
|room_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :from
- belongs_to :to


## entriesテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|references|null: false, foreign_key: true|
|room_id|references|null: false, foreign_key:true|

### Association
- belongs_to :room
- belongs_to :user

### relationテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|follow_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
-  belongs_to :follow