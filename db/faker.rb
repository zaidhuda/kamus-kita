# bin/rails runner db/faker.rb

p 'Creating AdminUser'
AdminUser.create! email: 'admin@kamuskita.com', password: 'longpassword'

p 'Generating Users'
(1..20).each do
  User.create! email: Faker::Internet.unique.email, password: 'longpassword'
end

p 'Generating Definitions'
(1..1000).each do
  User.find(rand(1..20)).definitions.create!(original_word: Faker::Lorem.word, definition: Faker::Lorem.paragraph, example: Faker::Lorem.paragraph)
end
