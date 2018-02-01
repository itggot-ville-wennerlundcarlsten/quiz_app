class App < Sinatra::Base

	
	require 'sinatra'
	require 'slim'
	require 'sqlite3'
	
	enable:sessions

	get('/') do
		slim(:index)
	end

	post('/create') do
		db = SQLite3::Database.new("db.sqlite")
		quizname = params["name"]
		db.execute("INSERT INTO quiz (name) VALUES (?)", [quizname])
		redirect('/')
	end

	get('/edit') do
		db = SQLite3::Database.new("db.sqlite")
		quiz = db.execute("SELECT name FROM quiz")
		slim(:edit,locals:{quiz:quiz})
	end

	get('/edit/?') do 
		slim(:edit_quiz_name)
	end 

	post('edit/?') do
		slim(:edit_quiz_name)
	end

end