//
//  ViewController.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/2/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checklist: Checklist!
    let editButtonSelector = Selector("editButtonPressed")
    let editSegueIdentifier = "EditItem"
    
    @IBOutlet var editButton: UIBarButtonItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = checklist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonPressed() {
        self.tableView.setEditing(!tableView.editing, animated: true)
        
        var rightBarButtonItems = self.navigationItem.rightBarButtonItems!
        
        let index = self.navigationItem.rightBarButtonItems!.indexOf(editButton)
        
        if tableView.editing {
            editButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: editButtonSelector)
        } else {
            editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: editButtonSelector)
        }
        
        rightBarButtonItems.insert(editButton, atIndex: index!)
        rightBarButtonItems.removeAtIndex(index! + 1)
        
        self.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
    }


    //pragma: MARK:- data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("CheckListItem", forIndexPath: indexPath)
        let label = cell.viewWithTag(1000) as! UILabel
        let checkmark = cell.viewWithTag(1001) as! UILabel
//        label.text = "Label" //if you don't reset the text, you get the old text value

        checkmark.text = checklist.items[indexPath.row].isChecked() ? "√" : ""
        label.text = checklist.items[indexPath.row].text
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            checklist.items[indexPath.row].toggleChecked()
            
            let checkmark = cell.viewWithTag(1001) as! UILabel
            checkmark.text = checklist.items[indexPath.row].isChecked() ? "√" : ""
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            checklist.items.removeAtIndex(indexPath.row)
            
            let indexPaths = [indexPath]
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Middle)
        }
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        checklist.items.insert(checklist.items[sourceIndexPath.row], atIndex: destinationIndexPath.row)
        checklist.items.removeAtIndex(sourceIndexPath.row + 1)
    }
    
    //pragma MARK:- ItemDetailViewControllerDelegate methods
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
        let indexPath = NSIndexPath(forItem: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem) {
        var indexPaths: [NSIndexPath]
        if let index = checklist.items.indexOf(item) {
            indexPaths = [NSIndexPath(forItem: index, inSection: 0)]
        } else {
            indexPaths = [NSIndexPath()]
        }
        
        self.tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // pragma MARK:- segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let navigationControler = segue.destinationViewController as! UINavigationController
        let controller = navigationControler.topViewController as! ItemDetailViewController
        controller.delegate = self
        
        if segue.identifier == editSegueIdentifier {
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
}

