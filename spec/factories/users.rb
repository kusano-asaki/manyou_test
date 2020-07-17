FactoryBot.define do
  factory :user do
    # id { 1 }
    name { 'sample1' }
    email { 'sss@sss.com' }
    password { '123456789' }
    password_confirmation { '123456789' }
    admin { 'false' }
  end

  factory :admin_user, class: User do
    # id { 1 }
    name { 'admin_sample1' }
    email { 'adminsss@sss.com' }
    password { '12345678910' }
    password_confirmation { '12345678910' }
    admin { 'true' }
  end
end
