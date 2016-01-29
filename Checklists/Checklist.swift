//
//  CheckList.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/7/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation
import UIKit

class Checklist: NSObject, NSCoding {
    var name = ""
    var items = [CheckListItem]()
    
    private var _uncheckedCount: Int {
        get {
            var count = 0
            for item in items {
                if !item.checked {
                    count += 1
                }
            }
            return count
        }
    }
    
    var uncheckedCount: Int {
        get {
            return _uncheckedCount
        }
    }
    
    var numberChecked: Int {
        get {
            return items.count - uncheckedCount
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [CheckListItem]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
    }
    
    override init() {
        super.init()
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
}