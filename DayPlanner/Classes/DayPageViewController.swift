//
//  DayPageViewController.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/15/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit
import CoreData

enum ContentType {
    case Day
    case Retros
    case Sessions
}

class DayPageViewController: UIPageViewController, ContextConfigurable {
    var context: NSManagedObjectContext!
    var contentType: ContentType = .Day {
        didSet {
            reloadData()
        }
    }

    var currentController: DayViewController? {
        get {
            return self.viewControllers?.first as? DayViewController
        }
    }

    var onDateChanged: ((NSDate, UIPageViewControllerNavigationDirection?)->Void)?

    func prepare(with context: NSManagedObjectContext) {
        self.context = context
        delegate = self
        dataSource = self
        if let dayController = dayViewController(on: NSDate()) {
            setViewControllers([dayController], direction: .Forward, animated: true, completion: nil)
        }
    }

    override func willMoveToParentViewController(parent: UIViewController?) {

        if var currentController = currentController {
            currentController.prepare(with: context)
            onDateChanged?(currentController.date, nil)
        }
    }

    override func setViewControllers(viewControllers: [UIViewController]?, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)?) {
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
        if let nextController = viewControllers?.first as? DayViewController {
            onDateChanged?(nextController.date, direction)
        }
    }

    func nextDate() {
        guard let currentController = currentController,
            let nextDate = currentController.date.dayAfter() else {
                return
        }
        setToDate(nextDate, animated: true)
    }

    func previousDate() {
        guard let currentController = currentController,
            let previousDate = currentController.date.dayBefore() else {
                return
        }
        setToDate(previousDate, animated: true)
    }

    func setToDate(date: NSDate, animated: Bool) {
        guard let currentController = currentController where !currentController.date.isEqualToDate(date) else {
            return
        }
        if let dayController = dayViewController(on: date) {
            let isAfterCurrentDate = currentController.date.compare(date) == .OrderedAscending
            let direction: UIPageViewControllerNavigationDirection = isAfterCurrentDate ? .Forward : .Reverse
            setViewControllers([dayController], direction: direction, animated: animated, completion: nil)
        }
    }

    func reloadData() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DayPageViewController: UIPageViewControllerDelegate {

    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {

        for var controller in pendingViewControllers.flatMap({ controller in controller as? ContextConfigurable }) {
            controller.prepare(with: context)
        }

        if let parent = parentViewController as? HomeViewController,
            let nextController = pendingViewControllers.first as? DayViewController {
            parent.dateButton.setTitle(nextController.date.description, forState: .Normal)
        }
    }

}

extension DayPageViewController: UIPageViewControllerDataSource {

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        switch contentType {
        case .Day:
            if let viewController = viewController as? DayViewController,
                let date = viewController.date,
                let dayBefore = date.dayBefore()
            {
                return dayViewController(on: dayBefore)
            }
        default:
            return nil
        }
        return nil
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        switch contentType {
        case .Day:
            if let viewController = viewController as? DayViewController,
                let date = viewController.date,
                let dayAfter = date.dayAfter()
            {
                return dayViewController(on: dayAfter)
            }
        default:
            return nil
        }
        return nil
    }

    func dayViewController(on date: NSDate) -> DayViewController? {
        let dayStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let dayController = dayStoryboard.instantiateViewControllerWithIdentifier("DayViewController") as? DayViewController
        dayController?.date = date
        return dayController
    }

}

extension NSDate {

    func dayAfter() -> NSDate? {
        return date(offsetBy: 1)
    }

    func dayBefore() -> NSDate? {
        return date(offsetBy: -1)
    }

    func date(offsetBy numberOfDays: Int) -> NSDate? {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: numberOfDays, toDate: self, options: NSCalendarOptions())
    }
}
