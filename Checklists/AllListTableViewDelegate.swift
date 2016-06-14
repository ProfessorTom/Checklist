//
//  AllListTableViewDelegate.swift
//  Checklists
//
//  Created by Tomas Gallucci on 6/13/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import UIKit



class AllListTableViewDelegate : NSObject, UITableViewDelegate, UITableViewDataSource {
    var dataModel: DataModel!
    
    var allListsViewController :AllListsViewController {
        get {
            var allListViewController: AllListsViewController!
            
            if let viewControllersOnScreen = UIApplication.sharedApplication().keyWindow?.rootViewController?.childViewControllers {
                
                let controllers = viewControllersOnScreen.filter({
                    $0.isKindOfClass(AllListsViewController)
                })
                allListViewController = controllers[0] as! AllListsViewController
            }
            return allListViewController; //in theory, this could return null. In pratice, not so much.
        }
    }
    
    // MARK: - Table view data source -
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ChecklistCellResuseIdentifier"
        let checklist = dataModel.lists[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            (cell as! ChecklistCell).updateCell(checklist)
            return cell
        } else {
            return ChecklistCell(reuseIdentifier: cellIdentifier, checklist: checklist)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        let checklist = dataModel.lists[indexPath.row]
        allListsViewController.performSegueWithIdentifier(AllListsViewController.SHOW_CHECKLIST_SEGUE, sender: checklist)
        
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataModel.lists.removeAtIndex(indexPath.row)
            
            let indexPaths = [indexPath]
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        }
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let navigationController = allListsViewController.storyboard!.instantiateViewControllerWithIdentifier("ListDetailNavigationController") as! UINavigationController

        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = allListsViewController

        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist

        allListsViewController.presentViewController(navigationController, animated: true, completion: nil)
    }
}