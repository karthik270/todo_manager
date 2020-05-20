class TodosController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
        #render plain: Todo.order(:due_date)
        #render plain: Todo.order(:due_date).map{|todo| todo.to_pleasant_string}.join("\n")
       render "index"
    end
    def show
        id = params[:id]
        todo = Todo.find(id)
        render "todo"
        #render plain: todo.to_pleasant_string
    end
    def create
        todo_text = params[:todo_text]
        due_date = DateTime.parse(params[:due_date])
        new_todo = Todo.create!(todo_text: todo_text, due_date: due_date, completed: false)
        response_text = "Hey, your new todo is created with the id #{new_todo.id}"
    end
    def update
        id = params[:id]
        completed = params[:completed]
        todo = Todo.find(id)
        todo.completed = completed
        todo.save!
        render plain: "Updated todo completed status to #{completed}"
    end 
end