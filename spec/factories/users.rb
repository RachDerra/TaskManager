FactoryBot.define do
  factory :user, class: User do
    name { "myuser" }
    email { "myuser@example.com" }
    password { "password" }
    role { 'false' }
  end

  factory :user_admin, class: User do
    name { "useradmin" }
    email { "useradmin@example.com" }
    password { "password" }
    role { 'true' }
  end
end
