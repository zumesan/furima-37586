# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birth_date         | date   | null: false               |

### Association

- has_many :products
- has_many :purchase_records

## destinations テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| post_number      | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| municipality     | string     | null: false                    |
| address          | string     | null: false                    |
| building_name    | string     |                                |
| phone_number     | string     | null: false                    |
| purchase_record  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :purchase_record

## products テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| product_name        | string     | null: false                    |
| product_info        | text       | null: false                    |
| category_id         | integer    | null: false                    |
| state_id            | integer    | null: false                    |
| shipping_fee_id     | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| date_of_shipping_id | integer    | null: false                    |
| price               | string     | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :purchase_record

## purchase_records テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| destination | references | null: false, foreign_key: true |
| product     | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one    :destination
- belongs_to :product