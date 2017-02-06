Notification.delete_all
ForumPost.delete_all
ForumThread.delete_all
User.delete_all

# Create a guy and his thread.
masa = User.create!(
  email:    "nishiguchi.masa@gmail.com",
  password: "password"
)
forum_thread = masa.forum_threads.create!(
  title: "Masa and friends"
)
masa.forum_posts.create!(
  forum_thread: forum_thread,
  body:         Faker::Lorem.paragraph
)

# Create a few members in that thread.
3.times do |i|
  user = User.create!(
    email:    "user#{i + 1}@example.com",
    password: "password"
  )
  user.forum_posts.create!(
    forum_thread: forum_thread,
    body:         Faker::Lorem.paragraph
  )
end

# All users create a few posts and notify the rest of the users.
forum_thread.users.each do |actor|
  notifiable = actor.forum_posts.create!(
    forum_thread: forum_thread,
    body:         Faker::Lorem.paragraph
  )
  (forum_thread.users - [actor]).each do |recipient|
    Notification.posted(recipient: recipient, actor: actor, notifiable: notifiable)
  end
end
