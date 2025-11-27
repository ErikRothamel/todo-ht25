require 'sinatra'
require 'sqlite3'
require 'slim'
require 'sinatra/reloader'





# Routen /
get '/todo' do
    
    db = SQLite3::Database.new("db/todos.db")

    db.results_as_hash = true

 
    @tododata = db.execute("SELECT * FROM todos")



    slim(:index)
end

post('/todo') do
  name = params[:name]
  description = params[:description]

  db = SQLite3::Database.new("db/todos.db")

  db.execute("INSERT INTO todos (name, description) VALUES (?, ?)", [name, description])

  redirect '/todo'
end

post ('/todos/:id/delete') do

  id = params[:id].to_i

  db = SQLite3::Database.new("db/todos.db")
  db.execute("DELETE FROM todos WHERE id = ?",id)

  redirect('/todo')
end

get('/todos/:id/edit') do
  
  db = SQLite3::Database.new("db/todos.db")
  db.results_as_hash = true
  id = params[:id].to_i
  @tododata = db.execute("SELECT * FROM todos WHERE id = ?",id).first
  slim(:edit)
end

post('/todos/:id/update') do
  id = params[:id].to_i
  name = params[:name]
  description = params[:description]

  db = SQLite3::Database.new("db/todos.db")
  db.execute("UPDATE todos SET name=?,description=? WHERE id=?",[name,description,id])

  redirect('/todo')
end

