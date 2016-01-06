//
//  ItemDetailViewControler.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/4/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation
import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    //prgam MARK:- outlets
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: CheckListItem?
    
    //pragma MARK:- ViewController lifecycle methods
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    //pragma MARK:- button handlers
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
         item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        } else {
        let item = CheckListItem(text: textField.text!, checked: false)
        delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
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