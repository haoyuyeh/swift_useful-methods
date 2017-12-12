//: Playground - noun: a place where people can play

import UIKit

// sort by current locale
let str1 = ["Hello", "a playground"]
let str2 = ["我", "小"]

let sortStr1 = str1.sorted { (s1, s2) -> Bool in
    return s1.localizedStandardCompare(s2) == .orderedAscending
}
// using superclass as function return type or parameter,
// doesnot solve the problem  wanting to pass subclass objects
class Objects {
    var name:String
    init(name: String) {
        self.name = name
    }
}
class item: Objects{
    var date = ""
    init(name: String, date: String) {
        self.date = date
        super.init(name: name)
        
    }
}
class Folder: Objects{
    var items = [item]()
    override init(name: String) {
        super.init(name: name)
    }
}
var item2 = [item]()
item2.append(item(name:"我", date:"11/01/2017"))
item2.append(item(name:"小", date:"30/05/2017"))
// compare String
let sortItem2 = item2.sorted { (s1, s2) -> Bool in
    return s1.name.localizedStandardCompare(s2.name) == .orderedAscending
}
print(sortItem2[0].name)
// compare date
func testSort(target: Array<item>?, target2: Array<Folder>?) -> Array<item>{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/mm/yyyy"
    
    return target!.sorted { (s1, s2) -> Bool in
        return dateFormatter.date(from: s1.date)?.compare(dateFormatter.date(from: s2.date)!)  == .orderedAscending
    }
}

let t = testSort(target: item2, target2: nil)
print("\(t[0].name) \(t[0].date)")
