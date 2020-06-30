# フレームワークバージョン
- Rails 5.2.4.3

# テーブル各種
## Userテーブル
- name :string
- email :string
- password_digest :string

## Taskテーブル
- name :string
- content :text
- priority :integer
- completed :integer
- end_at :datetime
- user_id :bigint

## Labelテーブル
- name :string

## Laberingテーブル
- task_id :bigint
- label_id :bigint
