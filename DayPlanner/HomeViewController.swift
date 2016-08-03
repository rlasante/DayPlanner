//
//  ViewController.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, ContextConfigurable {
    var context: NSManagedObjectContext!

    var pageViewController: DayPageViewController? {
        get {
            return childViewControllers.first as? DayPageViewController
        }
    }

    @IBOutlet var dateButton: UIButton!

    @IBAction func dateButtonPressed(sender: UIButton) {
        // Do nothing
    }

    @IBAction func previousDateButtonPressed(sender: UIButton) {
        pageViewController?.previousDate()
    }

    @IBAction func nextDateButtonPressed(sender: UIButton) {
        pageViewController?.nextDate()
    }

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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let dayPageController = segue.destinationViewController as? DayPageViewController {
            dayPageController.prepare(with: context)
            dayPageController.onDateChanged = { [weak self] (date, direction) in
                self?.dateButton.setTitle(date.description, forState: .Normal)
            }
        }
    }
    
}

extension HomeViewController: UITabBarDelegate {

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        switch item.tag {
        case 0:
            pageViewController?.contentType = .Day
        case 1:
            pageViewController?.contentType = .Retros
        case 2:
            pageViewController?.contentType = .Sessions
        default:
            assertionFailure()
        }
    }
}
