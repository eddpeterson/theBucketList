# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(id: "1637261457", email: "eddpeterson@gmail.com", first_name: "Edijs", last_name: "Petersons", name: "Edijs Petersons", goals: [
  Goal.get_new("Travel to Hawaii", "family"),
  Goal.get_new("Do stuff", "personal")
  ]
)
10.times do |n|
  user.goals << Goal.get_new("Goal to be acomplished: #{n}", "work")
end
20.times do |n|
  user.goals << Goal.get_new("Todo: #{n}", "social")
end
