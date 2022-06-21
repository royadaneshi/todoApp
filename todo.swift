import Foundation

class todoClass {
    var name: String
    var deadLine: Date
    var date_of_make: Date
    var todo_id: Int
    static var Id = 0
    static var all_todos = [todoClass]()

    init(name: String, deadLine: Date) {
        self.name = name
        self.deadLine = deadLine
        todoClass.Id += 1
        todo_id = todoClass.Id
        date_of_make = Date().toCurrentTimezone()
        todoClass.all_todos.append(self)
    }

    func get_name() -> String {
        return self.name
    }

    func get_deadLine() -> Date {
        return self.deadLine
    }

    func get_date_of_make() -> Date {
        return self.date_of_make
    }

    func get_todo_id() -> Int {
        return self.todo_id
    }

    public static func get_all_todos() -> [todoClass] {
        return all_todos
    }
}

extension Date {
    func toCurrentTimezone() -> Date {
        let timeZoneDifference =
                TimeInterval(TimeZone.current.secondsFromGMT())
        return self.addingTimeInterval(timeZoneDifference)
    }
}

func main() {
    let text = "\nwelcome to the todo app!"
        print(text)
        print("please enter number of option you want to select:")
        print("1.add new todo")
        print("2.see all todos")
        print("3.select date")
        print("4.logout")
        while (true) {
            let input = readLine()
            switch input {
            case "1":
                print("Make new todo:")
                add_new_todo()
            case "2":
                print("See all todos:")
                    show_todos()
            case "3":
                print("Select date:")
                    select_todos_date()
            case "4":
                exit(0)
            default:
                print("please enter a valid option ...")
            }
        }

    }
    
func add_new_todo() {
    var title = ""
    var due_date = Date()
    var temp: String
    while (true) {
        print("Enter todo's title : ")
        print("For canceling the process enter 'cancel'")
        title = readLine() ?? ""
        if (title == "cancel") {
            main()
        } else {
            if (title == "") {
                print("invalid input ...")
                continue
            } else {
                break
            }
        }
    }
    while (true) {
        print("Enter todo's due date in format 'yyyy-MM-dd'T'HH:mm:ss'+0000''")
        print("For canceling the process enter 'cancel'")
        temp = readLine() ?? ""
        if (temp == "cancel") {
            main()
        } else {
            if (temp == "") {
                print("invalid input ...")
                continue
            } else {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                if dateFormatterGet.date(from: temp) != nil {
                    // valid format
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    due_date = dateFormatter.date(from: temp)!
                    break
                } else {
                    // invalid format
                    print("invalid input format ...")
                    continue
                }
            }
        }
    }
    let object = todoClass(name: title, deadLine: due_date)

    print("Your todo by Id: ",object.get_todo_id())
    print("and name: ",object.get_name())
    print("and due date: ",object.get_deadLine())
    print("in date: ",object.date_of_make)
    print("has been created successfully!")
    main()
}

func show_todos() {
    let todos = sort_todos(todoClass.get_all_todos(),get_sort_type(), is_ascending())
    print_todos(todos)
    while true {
        print("1. remove a to do")
        print("2. back")
        let input = readLine()
        
        switch input {
        case "1":
            print_todos(todos)
            print("enter todo id to delete or enter back")
            var idToRemove : Int = 0;
            while true {
                let input_string:String! = readLine()
                
                if input_string == "back" {
                    main()
                }
                
                let temp :Int! = Int(input_string)
                if temp < todos.count {
                    idToRemove = temp
                    break
                }
                else {
                    print("is not a valid option try again")
                } 
            }
            let is_deleted = remove_todo(idToRemove)
            if(is_deleted){
                print("todo deleted successfully")
                main()
            }
            else {
                print("todo not found")
                main()
            }
        case "2":
            main() 
        default:
            print("Enter Valid Option")  
        }
        
    }
    
}

func remove_todo(_ id:Int) -> Bool {
        var is_todo_found = false
        for todo in todoClass.all_todos{
            if todo.todo_id == id {
                is_todo_found = true
            }
        }
        
        if (is_todo_found) {
           todoClass.all_todos.removeAll(where:{$0.todo_id == id})
        }
        return is_todo_found
    }

func get_sort_type() -> String {
    print("please select type of sort")
    print("1. by name")
    print("2. by created date")
    print("3. by due date")   
    print("4. back")
     

    while true {
    let type = readLine()
    switch type {
    case "1":
        return "name"
    case "2": 
        return "createdDate"
    case "3":
        return "deadLine"
    case "4":
        main()
    default : 
        print("please enter valid option")
    }
    }
}


func is_ascending() -> Bool {
    print("Enter A for Ascending and D for Descending or enter B to exit this menu")
    while true {
        let input = readLine()
        
        switch input {
        case "A":
            return true
        case "D":
            return false
        case "B":
            show_todos()
        default: print(" not a valid option, try again...")}
    }
}


func sort_by_name( _ todos:Array<todoClass>, _ is_ascending:Bool) -> Array<todoClass> {
    if(is_ascending){
        return todos.sorted {$0.name.lowercased() < $1.name.lowercased()}
    }else{
        return todos.sorted {$0.name.lowercased() > $1.name.lowercased()}
    }
}

func sort_by_deadLine( _ todos:Array<todoClass>, _ is_ascending:Bool) -> Array<todoClass> {
    if(is_ascending){
        return todos.sorted(by: { $0.deadLine.compare($1.deadLine) == .orderedAscending })
    }else{
        return todos.sorted(by: { $0.deadLine.compare($1.deadLine) == .orderedDescending })
    }
}

func sort_by_createdDate( _ todos:Array<todoClass>, _ is_ascending:Bool) -> Array<todoClass> {
    if(is_ascending){
        return todos.sorted(by: { $0.date_of_make.compare($1.deadLine) == .orderedAscending })
    }else{
        return todos.sorted(by: { $0.date_of_make.compare($1.deadLine) == .orderedDescending })
    }
}


func sort_todos( _ todos:Array<todoClass>, _ type_of_sort:String, _ ascending:Bool) -> Array<todoClass> {
    if (type_of_sort.lowercased() == "name") {
        return sort_by_name(todos ,ascending)
    }else if (type_of_sort == "createdDate") {
        return sort_by_createdDate(todos ,ascending)
    }else{
        return sort_by_deadLine(todos ,ascending)
    }
}


func print_todos(_ todos:Array<todoClass>) {
    for todo in todos{
        print("\(todo.todo_id)"+". "+"\(todo.name)"+" daedline : \(todo.deadLine) ")
    }
}


func select_todos_date(){
  var due_date = Date()
  var temp: String
  let dateFormatterGet = DateFormatter()
  dateFormatterGet.dateFormat = "yyyy-MM-dd"
  while true{
    print("Please select a date to show todos yyyy-MM-dd or back")
    temp = readLine() ?? ""
    if temp == "back" {
      main()
    }
    if dateFormatterGet.date(from: temp) != nil {
      due_date = dateFormatterGet.date(from: temp)!
      break
    } else {
      print("invalid input format ...")
      continue
    }
  }
  let all_todos = todoClass.get_all_todos()
  var select_todos = [todoClass]()
  for todo in all_todos {
    if(dateFormatterGet.string(from: todo.get_deadLine()) == dateFormatterGet.string(from: due_date) ){
      select_todos.append(todo)
    }
}
  if(select_todos.count == 0){
    print("No Todo to show you in this Date")
    main()
  }
  let selected_todos = sort_todos(select_todos,"deadLine", true)
  print_todos(selected_todos)
      while true {
        print("1. remove a to do")
        print("2. back")
        let input = readLine()
        
        switch input {
        case "1":
            print_todos(selected_todos)
            var idToRemove : Int = 0;
            while true {
                print("enter todo id to delete or enter cancel")
                let input_string:String! = readLine()
                if input_string == "cancel"{
                  break
                }
                let temp :Int! = Int(input_string)
                for td in selected_todos{
                  if(td.get_todo_id() == temp){
                    idToRemove = temp
                    break
                  }
                }
                if idToRemove != 0 {
                    break
                }
                else {
                    print("is not a valid option try again")
                } 
            }
            let is_deleted = remove_todo(idToRemove)
            if(is_deleted){
                print("todo deleted successfully")
                main()
            }
            else {
                print("cancel removing todo")
            }
        case "2":
            main() 
        default:
            print("Enter Valid Option")  
        }
        
    }
}


main()
