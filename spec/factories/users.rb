FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@gmail.com' }
    password { 'password' }
  end
end
