require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  title       { Faker::Lorem.words(5).join(' ') }
  name        { Faker::Name.name }
  description { Faker::Lorem.paragraphs(3).join("\n\n") }
  email       { Faker::Internet.email }
  password    { Faker::Lorem.words(2).join }
end

User.blueprint do
  email
  password
end

Album.blueprint do
  title
  description
  user { User.make }
end

Photo.blueprint do
  title
  description
  album { Album.make }
end
