//: Playground - noun: a place where people can play

import UIKit

// sort by current locale
let str1 = ["Hello", "a playground"]
let str2 = ["我", "小"]

let sortStr1 = str1.sorted { (s1, s2) -> Bool in
    return s1.localizedStandardCompare(s2) == .orderedAscending
}
class item{
    var name:String
    init(name: String) {
        self.name = name
    }
}
var item2 = [item]()
item2.append(item(name:"我"))
item2.append(item(name:"小"))
let sortItem2 = item2.sorted { (s1, s2) -> Bool in
    return s1.name.localizedStandardCompare(s2.name) == .orderedAscending
}
print(sortItem2[0].name)

