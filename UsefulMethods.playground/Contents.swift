//: Playground - noun: a place where people can play

import UIKit

// MARK: Array sorting

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
item2.append(item(name:"我", date:"11/5/2017"))
item2.append(item(name:"小", date:"30/05/2017"))
// compare String
let sortItem2 = item2.sorted { (s1, s2) -> Bool in
    return s1.name.localizedStandardCompare(s2.name) == .orderedAscending
}
print(sortItem2[0].name)
// compare date
func testSort(target: Array<item>?, target2: Array<Folder>?) -> Array<item>{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    
    return target!.sorted { (s1, s2) -> Bool in
        return dateFormatter.date(from: s1.date)?.compare(dateFormatter.date(from: s2.date)!)  == .orderedAscending
    }
}

let t = testSort(target: item2, target2: nil)
print("\(t[0].name) \(t[0].date)")


// MARK: pass data from Model to Controller

class ViewController: UIViewController {
    private let dataModel = DataModel()
    
    // 1-1. Callback as Completion Handler
    func callbackByCompletion() {
        dataModel.requestData { [weak self](data: String) in
            self?.useData(data: data)
        }
    }
    // 1-2. Callback as a class property
    func callbackByClassProperty() {
        dataModel.onDataUpdate = { [weak self] (data: String) in
            self?.useData(data: data)
        }
        dataModel.requestData()
    }
    
    private func useData(data: String) {
        print(data)
    }
    
    // 2. Delegation
    func passByDelegation() {
        dataModel.delegate = self
        dataModel.requestDataByDelegate()
    }
}
extension ViewController: DataModelDelegate {
    func didReceiveDataUpdate(data: String) {
        print(data)
    }
}




protocol DataModelDelegate: class {
    func didReceiveDataUpdate(data: String)
}
class DataModel {
    // 1-1. Callback as Completion Handler
    func requestData(completion: ((_ data: String) -> Void)) {
        // data type should be changed
        let data = "Data from wherever"
        completion(data)
    }
    // 1-2. Callback as a class property
    var onDataUpdate: ((_ data: String) -> Void)?
    func requestData() {
        // data type should be changed
        let data = "Data from wherever"
        onDataUpdate!(data)
    }
    
    // 2. Delegation
    weak var delegate: DataModelDelegate?
    func requestDataByDelegate() {
        let data = "Data from wherever"
        delegate?.didReceiveDataUpdate(data: data)
    }
}

let view = ViewController()
view.callbackByCompletion()
view.callbackByClassProperty()
view.passByDelegation()


















