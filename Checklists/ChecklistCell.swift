//
//  ChecklistCell.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/16/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import UIKit

class ChecklistCell: UITableViewCell {
    
    init(reuseIdentifier: String, checklist: Checklist) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)

        self.accessoryType = .DetailDisclosureButton
        updateCell(checklist)
    }
    
    func updateCell(checklist: Checklist) {
        self.textLabel!.text = checklist.name
        
        setSubtitleText(checklist)
    }
    
    private func setSubtitleText(checklist: Checklist) {
        let count = checklist.uncheckedCount
        
        if checklist.items.count == 0 {
            self.detailTextLabel!.text = "(No Items)"
        } else if count == 0 {
            self.detailTextLabel!.text = "All Done"
        } else {
            self.detailTextLabel!.text = "\(checklist.uncheckedCount) Remaining"
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
