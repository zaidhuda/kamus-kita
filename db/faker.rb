# bin/rails runner db/faker.rb

p 'Creating AdminUser'
AdminUser.create! email: 'admin@kamuskita.com', password: 'longpassword'

p 'Generating Users'
(1..20).each do
  User.create! email: Faker::Internet.unique.email, password: 'longpassword'
end

p 'Generating Definitions'
(1..1000).each do
  definition = Faker::Lorem.paragraph
  definition = definition.insert(rand(10..definition.size-10), " [#{Faker::Lorem.word}] ")

  example = Faker::Lorem.paragraph
  example = example.insert(rand(10..example.size-10), " [#{Faker::Lorem.word}] ")

  User.find(rand(1..20)).definitions.create!(original_word: Faker::Lorem.word, definition: definition, example: example)
end
