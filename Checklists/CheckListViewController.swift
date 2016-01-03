//
//  ViewController.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/2/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var checkListItems: [CheckListItem]
    
    
    required init?(coder aDecoder: NSCoder) {

        let row0item = CheckListItem(text: "This is the song that never ends", isChecked: true)
        let row1item = CheckListItem(text: "Round the rugged rock, the ragged rascle ran", isChecked: true)
//        let row2item = CheckListItem(text: "She sells seashells by the seashore", isChecked: true)
        let row2item = CheckListItem(text: "Label", isChecked: true)
        let row3item = CheckListItem(text: "Learn iOS Development", isChecked: true)
        let row4item = CheckListItem(text: "Eat ice cream", isChecked: true)
        
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
//        label.text = "Label" //if you don't reset the text, you get the old text value
        

        cell.accessoryType = checkListItems[indexPath.row].isChecked ? .Checkmark : .None
        label.text = checkListItems[indexPath.row].text
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            checkListItems[indexPath.row].isChecked = !checkListItems[indexPath.row].isChecked
            cell.accessoryType = checkListItems[indexPath.row].isChecked ? .Checkmark : .None
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

