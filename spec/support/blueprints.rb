require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  title       { Faker::Lorem.words(5).join(' ') }
  name        { Faker::Name.name }
  description { Faker::Lorem.paragraphs(3).join("\n\n") }
  email       { Faker::Internet.email }
  password    { 10.times.map { ('a'..'z').to_a[rand 26] }.join }
end

User.blueprint do
  email
  password
end

Album.blueprint do
  title
  description
  user
end

Photo.blueprint do
  title
  description
  album
end
