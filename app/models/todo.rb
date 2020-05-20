class Todo < ActiveRecord::Base
    def to_pleasant_string
        is_completed = completed ? "[X]" : "[ ]"
        "#{id}, #{due_date.to_s(:long)}, #{todo_text} #{is_completed}"
    end
    def self.overdue
        all.where("due_date < ?", Date.today)
    end

    def self.due_today
        all.where("due_date = ?", Date.today)
    end

    def self.due_later
        all.where("due_date > ?", Date.today)
    end

    def due_today?
        due_date == Date.today
    end

    def self.completed
        all.where(completed: true)
    end
  
    def self.show_list
    
      puts "\nMy Todolist"
      puts "\nOverdue"
      puts overdue.map { |todo| todo.to_displayable_string }
      puts "\nDue Today"
      puts due_today.map { |todo| todo.to_displayable_string }
      puts "\nDue Later"
     
      puts due_later.map { |todo| todo.to_displayable_string }
    end
    def self.mark_as_complete!(id)
        todo=Todo.find(id)
        todo.completed=true
        todo.save
        todo
    end
end