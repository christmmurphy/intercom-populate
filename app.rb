require "rubygems"
require "sinatra"
require "intercom"
require "faker"


number_of_users = 100
number_of_companies = 20


get '/' do
  erb :index
end

get '/completed' do
  erb :completed
end

get '/control' do
  erb :control
end


get '/populate' do
  erb :populate
end

post '/seed' do
	pat = params[:pat]
	@intercom = Intercom::Client.new(token: pat)



	@user_id = []
	number_of_users.times do
		@user_id << rand(300)
	end

	company_id = []
	number_of_companies.times do
		company_id << rand(100..500)
	end

	company_name = []
	number_of_users.times do
	  company_name << Faker::App.name
	end

	monthly_spend = []
	number_of_users.times do
		monthly_spend << rand(600..2000)
	end


	def user_and_company_generator(company_id, company_name, monthly_spend)

		@user_id.count do
			@intercom.users.submit_bulk_job(
				create_items: [
					{
						user_id: @user_id.pop,
						email: "#{Faker::Name.first_name}@example.com",
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
		@user_id.count.times do
			@intercom.contacts.create(:email => "#{Faker::Internet.email}")
		end
	end

	puts "Populating your lovely test app with some fake users and companies. Hang tight! :)"
	70.times do
		print '•'
	end
	user_and_company_generator(company_id[0], company_name[0], monthly_spend[0])
	user_and_company_generator(company_id[1], company_name[1], monthly_spend[1])
	user_and_company_generator(company_id[2], company_name[2], monthly_spend[2])
	# lead_generator
	puts
	puts "All done! Now either add conversations by running 'ruby convo_seed.rb' or go play with your new users!"

	erb :completed
end

post '/conversations' do
    #Determine Which CSV To Use
    puts "You selected #{params[:role]}"

    # Open Spreadsheet
    get_csv = "#{params[:role]}"
    if get_csv = "csr"
      csv_text = File.read("https://cl.ly/a4f78da3a63b/csr.csv")
    elsif get_csv = "cse"
      csv_text = File.read("https://cl.ly/abd0a3ee50fa/cse.csv")
    else
      csv_text = File.read("https://cl.ly/7aa520d2d8db/csl.csv")



    # Create array of questions
    questions = []
      csv_text.each_line {|line|
       questions << line
     }

    # Goes through each user, grabs their ID and populates the inbox with questions
    def populate(questions)
      pat = params[:pat]
      intercom = Intercom::Client.new(token: pat)
    	index = 0
    	intercom_id = []
    	intercom.users.all.each do |user|
        sleep(0.5)
    		intercom_id << user.id
    		intercom.messages.create(
    		  :from => {
    		    :type => "user",
    		    :id => user.id
    		  },
    		  :body => questions[index]
    		)
    	#I'm sure there's a better way to do this in Ruby
        index = index + 1
        break if index >= questions.count #Stop when you've used up all the questions in the CSV.
    	end
    end
    populate(questions)
    erb :completed
end
