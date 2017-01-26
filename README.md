# Intercom-User-Generator
A ruby script that populates your Intercom test app with users, companies and leads.

By default, it will populate your test app with 15 users, 3 companies, and 5 leads. 
Those settings can be changed by editing the code, feel free to play around with it and ping me if you have any questions or suggestions!

### How to use:
1. Clone the repo to your desktop.
2. In the terminal, navigate to the repo folder and run `bundle install`.
3. Make sure you have extended scope on your personal access token in your Intercom test app.
4. In the terminal, run the script by typing `ruby app.rb PASTE_YOUR_PERSONAL_ACCESS_TOKEN_HERE`.

# Intercom-Conversation-Generator
A Ruby script that takes each line of a CSV to use as in a conversation User Initiated Conversation. You can add and edit the questions in the CSV before running. 
This sections assumes you have already created your users. 

###How to use:
Run `ruby convo_seed.rb` and paste your Personal Access Token when prompted.
