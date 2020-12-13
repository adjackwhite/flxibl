# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require 'faker'

puts "Cleaning database"

Network.destroy_all
Profile.destroy_all
User.destroy_all
Skill.destroy_all

puts "Database cleaned"

20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123456",
    whatsapp_number: Faker::PhoneNumber.cell_phone_in_e164,
    manager: [true, false].sample
  )
  puts "#{User.count} users created"
end

40.times do
  Skill.create!(
    skill: Faker::Job.key_skill
  )
end


User.where(manager: false).each do |user|
  profile = Profile.create!(
    user: user,
    profession: Faker::Job.position,
    bio: Faker::Lorem.paragraph(sentence_count: 4),
    location: Faker::Address.city
  )
  file = URI.open('https://i.pravatar.cc/300')
  profile.photo.attach(io: file, filename: 'profile_img.jpg', content_type: 'image/png')
  puts "#{Profile.count} profiles created"
  rand(2..5).times do
    ProfileSkill.create(skill: Skill.all.sample, profile: profile )
  end

  rand(1..3).times do
    WebsiteLink.create(url: "www.google.com", label: "Google", profile: profile )
  end

  rand(1..3).times do
  Note.create(content: Faker::Quote.jack_handey, profile: profile )
end

managers = User.where(manager: true)
freelancers = User.where(manager: false)

managers.each do |manager|
  freelancers.each do |freelancer|
    Network.create!(
      user: manager,
      profile: freelancer.profile
    )
    puts "#{Network.count} networks created"
  end
end
