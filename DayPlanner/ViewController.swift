//
//  ViewController.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, ContextConfigurable {
    var context: NSManagedObjectContext!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        context = AppDelegate.sharedAppDelegate.managedObjectContext
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        context = AppDelegate.sharedAppDelegate.managedObjectContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

