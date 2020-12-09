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

puts "Database cleaned"

80.times do
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
    lowest_day_rate: [50..100].sample,
    highest_day_rate: [200..400].sample,
    location: Faker::Address.city
  )
  puts "#{Profile.count} profiles created"
  rand(2..5).times do
    ProfileSkill.create(skill: Skill.all.sample, profile: profile )
  end

  rand(1..3).times do
    WebsiteLink.create(url: "www.google.com", label: "Google", profile: profile )
  end
end

managers = User.where(manager: true)
freelancers = User.where(manager: false)

managers.each do |manager|
  freelancers.each do |freelancer|
    Network.create!(
      user: manager,
      profile: freelancer.profile
    )
  end
end
