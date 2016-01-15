//
//  CheckList.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/7/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation
import UIKit

class Checklist: NSObject {
    var name = ""
    
    override init() {
        super.init()
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
}