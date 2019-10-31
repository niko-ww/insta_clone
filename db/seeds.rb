# ユーザー
User.create!(
  name:  "Example User",
  username: "example user",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  )

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(
    name:  name,
    username: name,
    email: email,
    password:              password,
    password_confirmation: password,
    )
end

# 投稿
users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(1)
users.each { |user| user.posts.create!(title: content,
                                        picture: open("#{Rails.root}/public/sample.png"))}
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }