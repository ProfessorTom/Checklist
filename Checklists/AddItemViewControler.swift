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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        print("luser gave us: \(textField.text!)")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var textField: UITextField!
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
}