User.delete_all

3.times do |i|
  user = User.create!(
    email:    "user#{i + 1}@example.com",
    password: "password"
  )
end
