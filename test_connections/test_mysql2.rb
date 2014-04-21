require 'mysql2'

begin
	@server = 'localhost'
	@username = 'root'
	@password = ''
	@database = 'integrace'

	db = Mysql2::Client.new(:host => @server, :username => @username, :password => @password, :database => @database)
	end
ensure
  db.close if db
end