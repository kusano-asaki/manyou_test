# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name:'test_task',
  email:'task@ttt.com',
  password:'123456789',
  password_confirmation:'123456789',
  admin: true
)

Label.create!(
  name: 'プライベート'
)

Label.create!(
  name: '仕事'
)

Label.create!(
  name: '外出'
)

Label.create!(
  name: '家事'
)
