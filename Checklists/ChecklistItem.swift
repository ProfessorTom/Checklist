//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/2/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation

class CheckListItem: NSObject {
    //TODO: add the enumeration for row accessories as a property
    var text: String
    var checked = false
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func isChecked() -> Bool {
        return checked
    }
}