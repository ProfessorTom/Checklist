//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/2/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation

class CheckListItem: NSObject, NSCoding {
    //TODO: add the enumeration for row accessories as a property
    var text: String
    var checked = false
    
    override init() {
        print("in default CheckListItem constructor")
        self.text = ""
        self.checked = false
        
        super.init()
    }
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.text, forKey: "Text")
        aCoder.encodeBool(self.checked, forKey: "Checked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = aDecoder.decodeObjectForKey("Text") as! String
        self.checked = aDecoder.decodeBoolForKey("Checked")
        
        super.init()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func isChecked() -> Bool {
        return checked
    }
}