//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/2/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation

class CheckListItem {
    let text: String
    private var checked = false
    
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