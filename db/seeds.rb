User.create!(name:"example",email: "admin@example.com",password:"12345678",password_confirmation:"12345678",role:true)

10.times do |n|
    Label.create!(name: Faker::Color.color_name)
    User.create!(
      name: Faker::Creature::Animal.name,
      email: Faker::Internet.email,
      password: "password"
                 )
end
  
  10.times do |n|
    Task.create!(
      name: "task#{n+1}",
      retail: "detail#{n+1}",
      dead_line: DateTime.now,
      status: rand(1..3),
      priority: rand(1..3),
      user_id: rand(1..10)
                 )
  end