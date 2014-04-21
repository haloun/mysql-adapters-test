require 'net/http' # gem for http communication (included in ruby)
require 'json'     # gem for parsing json (gem install json)
require 'csv'	   # for saving results to csv for further use

# tested database adapters
require 'mysql'   		# gem install mysql
require 'mysql2'  		# gem install mysql2
require 'dbi'	  		# gem install dbi, gem install dbd-mysql
require 'active_record'  # gem install activerecord

# variables for database connection
@server = 'localhost'
@username = 'root'
@password = ''
@database = 'integrace'
@adapter = 'mysql2'

=begin
# Class for active record ORM mapping
class Tvshow < ActiveRecord::Base  
end
=end
	
# Methods for connection to the database through various adapters
def mysql_adapter(record)
	begin
		db = Mysql.new(@server, @username, @password, @database)
		db.query("INSERT INTO tvshows (show_name) values ('#{record}')")
	ensure
		db.close if db
	end
end

def mysql2_adapter(record)
	begin
		db = Mysql2::Client.new(:host => @server, :username => @username, :password => @password, :database => @database)
		db.query("INSERT INTO tvshows (show_name) values ('#{record}')")
	ensure
		db.close if db
	end
end

def dbi_adapter(record)
	begin
		db = DBI.connect("DBI:Mysql:integrace:localhost", "root", "")
		db.do("INSERT INTO tvshows (show_name) values ('#{record}')")
	ensure
		db.disconnect if db
	end
end

def active_record_adapter(record)
	begin
		db = ActiveRecord::Base.establish_connection(:adapter => @adapter, :host => @server, :database => @database) 
		#Tvshow.create(:movie_name => show_name)
		db.connection.execute("INSERT INTO tvshows (show_name) values ('#{record}')")
	ensure
		db.disconnect! if db
	end
end

# ============== settings ==============
# variables for repetitions
no_of_repetitions = 2
no_of_connections = 1000
# Possibilities 'mysql_adapter', 'mysql2_adapter', 'dbi_adapter', 'active_record_adapter'
adapter = 'mysql_adapter'
# ============== end of settings ==============

# Fetches JSON string with tv shows,
# parse it to ruby hash and then creates array with 10 movies
webpage_uri = URI('https://api.themoviedb.org/3/discover/tv?api_key=3a515daf828f9cb0c6840b1a248aafee')
tvshow_json = Net::HTTP.get(webpage_uri)
tvshow_hash = JSON.parse(tvshow_json)
tvshows = tvshow_hash.values[1]

show_names = Array.new
tvshows.take(10).each do |show|
	show_names << show["original_name"]
end

results = Array.new
no_of_repetitions.times do
	# Saves start time
	start = Time.now
		# Repeats the experiment with the adapter set in variable adapter
		no_of_connections.times do
			show_names.each do |show|
				send(adapter.to_s, show)
			end
		end
	finish = Time.now

	puts (finish - start)
	results << (finish - start)
end

# Saves results to a csv file
File.open('results.csv', 'w+') do |file|
	results.each do |result|
		file.puts result.to_s
	end
end




