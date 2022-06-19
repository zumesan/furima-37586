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

- has_many :destinations
- has_many :products
- has_many :purchase_records

## destinations テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| first_name      | string | null: false |
| last_name       | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana  | string | null: false |
| post_number     | string | null: false |
| prefectures     | string | null: false |
| municipality    | string | null: false |
| adress          | date   | null: false |
| building_name   | string | null: false |
| phone_number    | string | null: false |

### Association

- belongs_to :user
- has_one    :purchase_record

## products テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| product_image    | string     | null: false                    |
| product_name     | string     | null: false                    |
| product_info     | string     | null: false                    |
| category         | string     | null: false                    |
| status           | string     | null: false                    |
| shipping_fee     | string     | null: false                    |
| prefectures      | string     | null: false                    |
| date_of_shipping | string     | null: false                    |
| user             | references | null: false, foreign_key: true |

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
- belongs_to :destination
- belongs_to :product