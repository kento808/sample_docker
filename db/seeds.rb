User.create!(username:  "Example User",
             email: "example@railstutorial.org",
             profile:               "Hello world!",
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
99.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username:  username,
               email: email,
               profile:               "Hello!",
               password:              password,
               password_confirmation: password)
end


Category.create(name: 'レジャー')
Category.create(name: 'グルメ')
Category.create(name: 'ホテル・施設系')
Category.create(name: 'その他')
# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
20.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each do |user| user.posts.create!(content: content, category_id: 1, address: '沖縄県　那覇市')
  user.posts.each do |post| post.image.attach(io: File.open('app/assets/images/ishigakijimanoumi.jpg'), filename: 'ishigakijimanoumi.jpg')
  end
 end
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
