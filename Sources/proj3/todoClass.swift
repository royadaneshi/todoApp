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