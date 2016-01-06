//
//  ViewController.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/2/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checkListItems: [CheckListItem]
    
    
    required init?(coder aDecoder: NSCoder) {

        let row0item = CheckListItem(text: "This is the song that never ends", checked: true)
        let row1item = CheckListItem(text: "Round the rugged rock, the ragged rascle ran", checked: true)
//        let row2item = CheckListItem(text: "She sells seashells by the seashore", checked: true)
        let row2item = CheckListItem(text: "Label", checked: true)
        let row3item = CheckListItem(text: "Learn iOS Development", checked: true)
        let row4item = CheckListItem(text: "Eat ice cream", checked: true)
        
        checkListItems = [CheckListItem]()
        checkListItems.append(row0item)
        checkListItems.append(row1item)
        checkListItems.append(row2item)
        checkListItems.append(row3item)
        checkListItems.append(row4item)
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //pragma: MARK:- data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkListItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("CheckListItem", forIndexPath: indexPath)
        let label = cell.viewWithTag(1000) as! UILabel
        let checkmark = cell.viewWithTag(1001) as! UILabel
//        label.text = "Label" //if you don't reset the text, you get the old text value

        checkmark.text = checkListItems[indexPath.row].isChecked() ? "√" : ""
        label.text = checkListItems[indexPath.row].text
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            checkListItems[indexPath.row].toggleChecked()
            
            let checkmark = cell.viewWithTag(1001) as! UILabel
            checkmark.text = checkListItems[indexPath.row].isChecked() ? "√" : ""
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            checkListItems.removeAtIndex(indexPath.row)
            
            let indexPaths = [indexPath]
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Middle)
        }
    }
    
    //pragma MARK:- ItemDetailViewControllerDelegate methods
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem) {
        
        let newRowIndex = checkListItems.count
        checkListItems.append(item)
        
        let indexPath = NSIndexPath(forItem: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem) {
        var indexPaths: [NSIndexPath]
        if let index = checkListItems.indexOf(item) {
            indexPaths = [NSIndexPath(forItem: index, inSection: 0)]
        } else {
            indexPaths = [NSIndexPath()]
        }
        
        self.tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let navigationControler = segue.destinationViewController as! UINavigationController
        let controller = navigationControler.topViewController as! ItemDetailViewController
        controller.delegate = self
        
        if segue.identifier == "EditItem" {
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = checkListItems[indexPath.row]
            }
        }

    }
}

