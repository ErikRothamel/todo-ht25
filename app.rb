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


