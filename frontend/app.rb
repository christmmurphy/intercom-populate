require "rubygems"
require "sinatra"
require "intercom"
require "faker"


get '/' do
  erb :index
end


get '/populate' do
  erb :populate
end

post '/seed' do
	puts pat
	intercom = Intercom::Client.new(token: pat)

	user_id = []
	15.times do 
		user_id << 1.next
	end

	company_id = []
	3.times do
		company_id << rand(300..500)
	end

	company_name = []
	3.times do
	  company_name << Faker::App.name
	end

	monthly_spend = []
	3.times do 
		monthly_spend << rand(600..2000)
	end

	5.times do
		intercom.users.submit_bulk_job(create_items: [{user_id: user_id.pop, email: "#{Faker::Internet.email}", name: "#{Faker::StarWars.character}", last_seen_ip: "#{Faker::Internet.public_ip_v4_address}", custom_attributes: {
			favorite_beer: "#{Faker::Beer.name}",
			last_caught_pokemon: "#{Faker::Pokemon.name}",
			money_in_bank: "#{Faker::Number.decimal(2)}"
			}, companies: [{:company_id => company_id[0], :name => "#{company_name[0]}", :monthly_spend => monthly_spend[0] }]}])
	end

	5.times do
		intercom.users.submit_bulk_job(create_items: [{user_id: user_id.pop, email: "#{Faker::Internet.email}", name: "#{Faker::StarWars.character}", last_seen_ip: "#{Faker::Internet.public_ip_v4_address}", custom_attributes: {
			favorite_beer: "#{Faker::Beer.name}",
			last_caught_pokemon: "#{Faker::Pokemon.name}",
			money_in_bank: "#{Faker::Number.decimal(2)}"
			}, companies: [{:company_id => company_id[1], :name => "#{company_name[1]}", :monthly_spend => monthly_spend[1] }]}])
	end

	5.times do
		intercom.users.submit_bulk_job(create_items: [{user_id: user_id.pop, email: "#{Faker::Internet.email}", name: "#{Faker::StarWars.character}", last_seen_ip: "#{Faker::Internet.public_ip_v4_address}", custom_attributes: {
			favorite_beer: "#{Faker::Beer.name}",
			last_caught_pokemon: "#{Faker::Pokemon.name}",
			money_in_bank: "#{Faker::Number.decimal(2)}"
			}, companies: [{:company_id => company_id[2], :name => "#{company_name[2]}", :monthly_spend => monthly_spend[2] }]}])
	end

		"I've gone and done that!"
	end











