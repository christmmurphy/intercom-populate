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
	pat = params[:pat]

	@intercom = Intercom::Client.new(token: pat)


	@user_id = []
	params[:number_of_users].to_i.times do
		@user_id << rand(300)
	end

	company_id = []
	params[:number_of_companies].to_i.times do
		company_id << rand(100..500)
	end

	company_name = []
	params[:number_of_companies].to_i.times do
	  company_name << Faker::App.name
	end

	monthly_spend = []
	params[:number_of_companies].to_i.times do
		monthly_spend << rand(600..2000)
	end


	def user_and_company_generator(company_id, company_name, monthly_spend)

		5.times do
			@intercom.users.submit_bulk_job(
				create_items: [
					{
						user_id: @user_id.pop,
						email: "#{Faker::Internet.email}",
						name: "#{Faker::Superhero.name}",
						last_seen_ip: "#{Faker::Internet.public_ip_v4_address}",
						phone: "#{Faker::PhoneNumber.cell_phone}",
						signed_up_at: Time.now.to_i,
						custom_attributes: {
							superpower: "#{Faker::Superhero.power}",
					    favorite_beer: "#{Faker::Beer.name}",
							last_caught_pokemon: "#{Faker::Pokemon.name}",
							money_in_bank: "#{Faker::Number.decimal(2)}"
				    },
					  companies: [
					  	{
					  		:company_id => company_id,
					  		:name => "#{company_name}",
					  		:monthly_spend => monthly_spend
					  	}
					  ]
				  }
				]
			)

		end
	end

	def lead_generator
		5.times do
			@intercom.contacts.create(:email => "#{Faker::Internet.email}")
		end
	end

	puts
	puts "Populating your lovely test app with some fake users and companies. Hang tight! :)"
	70.times do
		print '•'
		sleep 0.1
	end
	user_and_company_generator(company_id[0], company_name[0], monthly_spend[0])
	user_and_company_generator(company_id[1], company_name[1], monthly_spend[1])
	user_and_company_generator(company_id[2], company_name[2], monthly_spend[2])
	# lead_generator
	puts
	puts "All done! Now either add conversations by running 'ruby convo_seed.rb' or go play with your new users!"

	erb :index
end
