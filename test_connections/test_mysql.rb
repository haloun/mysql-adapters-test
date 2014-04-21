require 'mysql'

begin
	@server = 'localhost'
	@username = 'root'
	@password = ''
	@database = ''

	db = Mysql.real_connect(@server, @username, @password, @database)
	puts "Server version: " + db.get_server_info

rescue Mysql2::Error => e
	puts "Error code: #{e.errno}"
	puts "Error message: #{e.error}"
	puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
ensure
  db.close if db
end