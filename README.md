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

# Herokuデプロイ手順
1. コミットまですませておく
2. heroku login
3. rails assets:precompile RAILS_ENV=production
4. heroku create
5. heroku buildpacks:set heroku/ruby
   heroku buildpacks:add --index 1 heroku/nodejs
6. git push heroku master
7. heroku run rails db:migrate
