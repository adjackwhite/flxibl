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
Note.destroy_all

puts "Database cleaned"

30.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123456",
    whatsapp_number: Faker::PhoneNumber.cell_phone_in_e164,
    manager: [true, false].sample,
    company: Faker::Company.name,
    title: ["Studio Manager", "Project Manager", "Marketing Manager", "Head of creative", "Warehouse Manager", "Lead Project Manager", "General Manager", "Resource Manager"].sample
  )
  Profile.last&.destroy
  puts "#{User.count} users created"
  if user.manager
    file = URI.open('https://i.pravatar.cc/300')
    user.photo.attach(io: file, filename: 'profile_img.jpg', content_type: 'image/png')
  end
end

["Adobe Acrobat",
    "Adobe Creative Suite",
    "Javascript",
    "Adobe Flash",
    "Adobe Illustrator",
    "Adobe InDesign",
    "Adobe Photoshop",
    "Dreamweaver",
    "CSS",
    "HTML",
    "Quark",
    "QuarkXpress",
    "Photo Editing"].each { |skill| Skill.create(skill: skill)}

User.where(manager: false).each do |user|
  profile = Profile.create!(
    user: user,
    profession: ["Photographer",
    "Stylist",
    "UX Designer",
    "Marketing Specialist",
    "Videographer",
    "Translator",
    "Copywriter",
    "Graphic Designer",
    "Front-end Developer",
    "Back-end Developer",
    "Art Director",
    "Retoucher"].sample,
    bio: ["I am a UX/UI Designer with over 10 years experience driving successful design solutions for web and device UI customization - both interaction and visual design. I’m passionate about designing and finding solutions in order to satisfy user and business needs. I'm highly collaborative and blend creative, technical and management experience to lead projects from inception through completion.", "2 things are central keys to my work, knowledge and deep observation, which I believe are the best practice to encounter and solve visual problems. I developed as illustrator and fine artist alongside my professional development in design and visual branding, always had the goal of accompanying design structural elements with the right aesthetics, in the seek of big ideas."].sample,
    location: ["London", "Paris", "Dubai", "Berlin"].sample
  )
  file = URI.open('https://i.pravatar.cc/300')
  profile.photo.attach(io: file, filename: 'profile_img.jpg', content_type: 'image/png')
  puts "#{Profile.count} profiles created"

  rand(2..5).times do
    ProfileSkill.create(skill: Skill.all.sample, profile: profile )
  end

links = { Dribbble: "www.dribbble.com", Instagram: "www.instagram.com", LinkedIn: "www.linkedin.com"}
  rand(1..3).times do
    rand_key = links.keys.sample
    url = links[rand_key]
    WebsiteLink.create(url: url, label: rand_key, profile: profile )
  end

  rand(1..3).times do
    Note.create(content: Faker::Quote.jack_handey, profile: profile )
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
    puts "#{Network.count} networks created"
  end
end
