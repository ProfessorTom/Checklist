//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/7/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {

    var dataModel: DataModel!
    var allDel: AllListTableViewDelegate!

    static let SHOW_CHECKLIST_SEGUE = "ShowChecklist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.delegate = self
        
        let index = dataModel.indexOfSelectedChecklist
        
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegueWithIdentifier(AllListsViewController.SHOW_CHECKLIST_SEGUE, sender: checklist)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.delegate = allDel
        tableView.dataSource = allDel
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // pragam MARK:- segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("segue.indentifier: \(segue.identifier)")
        
        if segue.identifier == AllListsViewController.SHOW_CHECKLIST_SEGUE {
            let controller = segue.destinationViewController as! CheckListViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    
    // pragma MARK:- ListDetailViewControllerDelegate methods
    func listDetailViewcontrollerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist) {
        dataModel.lists.append(checklist)
        dataModel.sortChecklists()
        tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist) {
        dataModel.sortChecklists()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // pragma MARK:- UINavigationControllerDelegate methods
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }
 }
