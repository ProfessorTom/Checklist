//
//  AddItemViewControler.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/4/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController {
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}