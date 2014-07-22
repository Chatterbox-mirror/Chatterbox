# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.where(email: 'admin@example.com').destroy_all
AdminUser.create email: 'chatterbox@gitcafe.com', password: 'chatterbox', password_confirmation: 'chatterbox'
User.create name: 'Chatterbox', email: 'chatterbox@gitcafe.com', password: 'chatterbox', password_confirmation: 'chatterbox'