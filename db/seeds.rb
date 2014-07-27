# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "admin@omikron.com", password: "omikron", role: "admin")
User.create(email: "user@omikron.com", password: "omikron", role: "user")

Event.create(name: "Germany Bundesliga: FC Bayern München - VfL Wolfsburg",
  event_type: 0, first_side: "FC Bayern München", second_side: "VfL Wolfsburg",
  datetime_start: "2014-11-17 10:00:00 UTC", complete: false, count: "0:0",
  complete_type: 0)
