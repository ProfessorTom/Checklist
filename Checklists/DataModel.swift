//
//  DataModel.swift
//  Checklists
//
//  Created by Tomas Gallucci on 1/15/16.
//  Copyright © 2016 Blue Portal Productions. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [Checklist]()
    
    let CHECKLIST_INDEX_KEY = "ChecklistIndex"
    let CHECKLISTS_KEY = "Checklists"
    
    var indexOfSelectedChecklist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(CHECKLIST_INDEX_KEY)
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: CHECKLIST_INDEX_KEY)
        }
    }
    
    init() {
        loadCheckListItems()
        registerDefaults()
    }
    
    func registerDefaults() {
        let dictionary = [CHECKLIST_INDEX_KEY: -1]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    //pragma MARK:- documents directory methods
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() ->String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }
    
    //pragma MARK:- coder methods
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        archiver.encodeObject(lists, forKey: CHECKLISTS_KEY)
        archiver.finishEncoding()
        
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadCheckListItems() {
        let path = dataFilePath()
//        print("path: \(path)")
        //        print("file exists at path: \(NSFileManager.defaultManager().fileExistsAtPath(path))")
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey(CHECKLISTS_KEY) as! [Checklist]
                unarchiver.finishDecoding()
            }
        }
        
    }

}