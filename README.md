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
## users テーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_reading | string | null: false               |
| last_name_reading  | string | null: false               |
| birthday           | date   | null: false               |

### Association

--has_many :items
--has_many :orders

## items テーブル

| Column             | Type       | Options                       |
| ------------------ | -----------| ----------------------------- |
| name               | string     | null: false                   |
| explanation        | text       | null: false                   |
| price              | integer    | null: false                   |
| user               | references | null: false, foreign_key: true|
| category_id        | integer    | null: false                   |
| condition_id       | integer    | null: false                   |
| postagetype_id    | integer    | null: false                   |
| prefecture_id      | integer    | null: false                   |
| preparationday_id | integer    | null: false                   |

### Association

--belongs_to :user
--has_one :order
--belongs_to_active_hash :category
--belongs_to_active_hash :condition
--belongs_to_active_hash :postagetype
--belongs_to_active_hash :prefecture
--belongs_to_active_hash :preparationday

## orders テーブル

| Column             | Type       | Options                       |
| ------------------ | -----------| ----------------------------- |
| item               | references | null: false, foreign_key: true|
| user               | references | null: false, foreign_key: true|


### Association

--belongs_to :user
--belongs_to :item
--has_one :shipping_address

## shipping_addresses テーブル

| Column             | Type       | Options                      |
| ------------------ | -----------| -----------------------------|
| postal_code        | string     | null: false                  |
| prefecture_id      | integer    | null: false                  |
| city               | string     | null: false                  |
| house_number       | string     | null: false                  |
| building_name      | string     |                              |
| phone_number       | string     | null: false                  |
| order              | references | null: false,foreign_key: true|
### Association

--belongs_to :order
--has_one_active_hash :prefecture
