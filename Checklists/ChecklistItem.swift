//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/2/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation

class CheckListItem {
    var text = ""
    var isChecked = false
    
    init(text: String, isChecked: Bool) {
        self.text = text
        self.isChecked = isChecked
    }
}