class App < Sinatra::Base

	
	
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
		db.results_as_hash = true
		quiz = db.execute("SELECT * FROM quiz")
		slim(:edit,locals:{quiz:quiz})
	end

	get('/edit/:id') do
		db = SQLite3::Database.new("db.sqlite")
		quiz_id = params[:id]
		result = db.execute("SELECT * FROM quiz WHERE id=?", [quiz_id])
		slim(:edit_quiz_name, locals:{quiz:result})
	end 

	post('/edit/:id') do
		slim(:edit_quiz_name)
	end

	post('/name_edit/') do
		id = params[:id]
		new_name = params[:new_name]
		db = SQLite3::Database.new("db.sqlite")
		db.execute("UPDATE quiz SET name=? WHERE id=?", [new_name, id] )
		redirect('/edit/'+id)
	end

end