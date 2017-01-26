require 'intercom'
require 'csv'  

# Open Spreadsheet
csv_text = File.read('questions.csv')

# Create array of questions
questions = []  
    csv_text.each_line {|line|
     questions << line
   }	

# Goes through each user, grabs their ID and populates the inbox with questions
def populate(questions)
	index = 0
	intercom_id = []

	puts "Paste in your Personal Access Token:"
	pat = gets.chomp
	intercom = Intercom::Client.new(token: pat)
	puts "How many questions do you want to add? The max is: #{questions.length}"
	stop_point = gets.to_i

	intercom.users.all.each do |user| 
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
    break if index >= stop_point

	end
end

populate(questions)
