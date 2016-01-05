//
//  AddItemViewControler.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/4/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    //prgam MARK:- outlets
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    //pragma MARK:- ViewController lifecycle methods
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //pragma MARK:- button handlers
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        print("luser gave us: \(textField.text!)")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //pragma MARK:- table delegate methods
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //pragma MARK:- textField delegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
}