# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.any?
  User.create(email: "admin@omikron.com", password: "omikroner", role: 1, balance: 50) 
  User.create(email: "user@omikron.com", password: "omikroner", role: 0, balance: 0)
end

unless EventType.any?
  @et1 = EventType.create(name: "Football", description: "Football events")
  @et2 = EventType.create(name: "Hockey", description: "Hockey events")
end

unless CompleteType.any?
  @ct1 = CompleteType.create(result: "First side win", description: "First side win")
  @ct2 = CompleteType.create(result: "Second side win", description: "Second side win")
  @ct3 = CompleteType.create(result: "Draw", description: "Draw")
  @ct4 = CompleteType.create(result: "Match disruption", description: "All event's bets back")
end

unless Event.any?
  Event.create(name: "Germany Bundesliga",
    event_type: @et1, first_side: "FC Bayern München", second_side: "VfL Wolfsburg",
    datetime_start: "2014-11-17 10:00:00 UTC", complete: false, count: "0:0",
    complete_type: @ct1)
end

15.times do
  Event.create(name: "Germany Bundesliga",
    event_type: @et1, first_side: "FC Bayern München", second_side: "VfL Wolfsburg",
    datetime_start: "2014-11-17 10:00:00 UTC", complete: false, count: "0:0",
    complete_type: @ct1)
end
