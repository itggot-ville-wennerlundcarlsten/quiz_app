class App < Sinatra::Base

	get '/' do
		"Hello, Grillkorv!"
	end

end  

get('/') do
	slim(:home)
end

post('/create/') do
	db = SQLite3::Database.new("db.sqlite")
	quizname = params["name"]
