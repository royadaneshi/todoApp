import Foundation

@main
public struct proj3 {
    public private(set) var text = "\nwelcome to the todo app!"

    public static func main() {
        print(proj3().text)
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
                    //Todo see all todos
            case "3":
                print("Select date:")
                    //Todo Select date
            case "4":
                exit(0)
            default:
                print("please enter a valid option ...")
            }
        }

    }

}


@MainActor func add_new_todo() {
    var title = ""
    var due_date = Date()
    var temp: String
    while (true) {
        print("Enter todo's title : ")
        print("For canceling the process enter 'cancel'")
        title = readLine() ?? ""
        if (title == "cancel") {
            proj3.main()
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
            proj3.main()
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
    proj3.main()
}

