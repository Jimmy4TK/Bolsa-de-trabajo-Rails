# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
    Company.create([{name: "Jimmy SA", token: "58a0e38d-2c74-4fe5-b013-abb4b606747d"},{name: "Burgers SA", token: "510631c8-99d6-44c7-a912-e0363085cdd5"}])
    Candidate.create([{name: "Jimmy"},{name: "Teo"}])
    WorkNotification.create([{name: "Programmer", company_id: "1"},{name: "RRHH", company_id: "1"},{name: "Management", company_id: "2"}])
    StatusWorkNotification.create([{candidate_id: "1",work_notification_id:"1"},{candidate_id: "2",work_notification_id:"3"}])


