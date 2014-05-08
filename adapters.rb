require 'csv'	   # for saving results to csv

# tested database adapters
require 'mysql'   		# gem install mysql
require 'mysql2'  		# gem install mysql2
require 'dbi'	  		# gem install dbi, gem install dbd-mysql
require 'active_record'  # gem install activerecord

# variables for database connection
@server = 'localhost'
@username = 'root'
@password = ''
@database = 'soap'
@adapter = 'mysql2' # param used just for active record


# Class for active record ORM mapping
class Customer < ActiveRecord::Base
	has_many :items
end

class Customers_item < ActiveRecord::Base
end

class Item < ActiveRecord::Base
	has_many :customers
end

	
# Methods for connection to the database through various adapters
def mysql_adapter()

		# create the object and establish connection if doesn't exist
		if ($db).nil?
			$db = Mysql.new(@server, @username, @password, @database)
		end
=begin SECOND TEST
		$db.query("INSERT INTO customers (email, name) values ('test@test.com', 'pepaX');")
		$db.query("UPDATE customers SET email='test1@test.com', name='pepaY' WHERE name='pepaX';")
		$db.query("SELECT * FROM customers WHERE name='pepaY';")
		$db.query("DELETE FROM customers WHERE name='pepaY';")
=end


		$db.query('INSERT INTO customers_items(customer_id, item_id) values (1, 1);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (1, 2);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (1, 4);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 1);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 3);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 5);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 8);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 9);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (3, 1);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (3, 2);')
		#$db.query('SELECT * from customers_items;')
		$db.query("SELECT * FROM customers, customers_items, items WHERE  customers.id = customers_items.customer_id AND customers_items.item_id = items.id;") #just for FOURTH TEST

end

def mysql2_adapter()
		# create the object and establish connection
		if ($db).nil?
			$db = Mysql2::Client.new(:host => @server, :username => @username, :password => @password, :database => @database)
		end
=begin FIRST TEST
		$db.query("INSERT INTO customers (email, name) values ('test@test.com', 'pepaX');")
		$db.query("UPDATE customers SET email='test1@test.com', name='pepaY' WHERE name='pepaX';")
		$db.query("SELECT * FROM customers WHERE name='pepaY';")
		$db.query("DELETE FROM customers WHERE name='pepaY';")
=end

		$db.query('INSERT INTO customers_items(customer_id, item_id) values (1, 1);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (1, 2);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (1, 4);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 1);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 3);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 5);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 8);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (2, 9);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (3, 1);')
		$db.query('INSERT INTO customers_items(customer_id, item_id) values (3, 2);')
		#$db.query('SELECT * from customers_items;')
		$db.query("SELECT * FROM customers, customers_items, items WHERE  customers.id = customers_items.customer_id AND customers_items.item_id = items.id;") #just for FOURTH TEST

end

def dbi_adapter()
		# create the object and establish connection
		if ($db).nil?
			$db = DBI.connect("DBI:Mysql:soap:localhost", "root", "")
		end
=begin FIRST TEST
		$db.do("INSERT INTO customers (email, name) values ('test@test.com', 'pepaX');")
		$db.do("UPDATE customers SET email='test1@test.com', name='pepaY' WHERE name='pepaX';")
		$db.do("SELECT * FROM customers WHERE name='pepaY';")
		$db.do("DELETE FROM customers WHERE name='pepaY';")
=end


   	    #db.do('TRUNCATE TABLE customers_items;') #commmented out during the third test
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (1, 1);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (1, 2);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (1, 4);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (2, 1);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (2, 3);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (2, 5);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (2, 8);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (2, 9);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (3, 1);')
		$db.do('INSERT INTO customers_items(customer_id, item_id) values (3, 2);')
		#$db.do('SELECT * from customers_items;')
		$db.do("SELECT * FROM customers, customers_items, items WHERE  customers.id = customers_items.customer_id AND customers_items.item_id = items.id;") #just for FOURTH TEST
end

def active_record_adapter()
		# create the object and establish connection
		if ($db).nil?
			$db = ActiveRecord::Base.establish_connection(:adapter => @adapter, :host => @server, :database => @database)
		end
=begin FIRST TEST
		# insert
		user = Customer.create(email: 'test@test.com', name: 'pepaX')
		user.save
		# update
		user = Customer.find_by(name: 'pepaX')
		user.name = 'pepaY'
		user.save
		# select
		user = Customer.find_by(name: 'pepaY')
		# delete
		user = Customer.find_by(name: 'pepaY')
		user.destroy
=end

		#db.connection.execute("INSERT INTO tvshows (show_name) values ('#{record}')")
		cus_item = Customers_item.create(customer_id: 1, item_id: 1)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 1, item_id: 2)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 1, item_id: 4)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 2, item_id: 1)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 2, item_id: 3)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 2, item_id: 5)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 2, item_id: 8)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 2, item_id: 9)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 3, item_id: 1)
		cus_item.save
		cus_item = Customers_item.create(customer_id: 3, item_id: 2)
		cus_item.save
		# select
		#cus_items = Customers_item.all()
		Customer.joins(:customers_items, :items)

end

# ============== settings ==============
# variables for repetitions
no_of_connections = 15
no_of_repetitions = 100
# Possibilities 'mysql_adapter', 'mysql2_adapter', 'dbi_adapter', 'active_record_adapter'
adapter = 'active_record_adapter'
# ============== end of settings ==============

$db = nil
results = Array.new	

no_of_connections.times do
	start = Time.now

	no_of_repetitions.times do
		send(adapter.to_s)
	end

	$db = nil if $db

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



=begin NOT USED IN TESTS (it's just a snippet)
require 'net/http' # gem for http communication (included in ruby)
require 'json'     # gem for parsing json (gem install json)

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


=end




