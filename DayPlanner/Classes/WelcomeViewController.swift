//
//  WelcomeViewController.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/9/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit
import CoreData

class WelcomeViewController: UIViewController, ContextAware {
    private static let toHomeSegueIdentifier = "WelcomeToHome"
    private static let toGoalsSegueIdentifier = "WelcomeToGoals"

    @IBOutlet weak var welcomeLabel: UILabel!

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

        welcomeLabel.text = wecomeStringForTime()
    }

    override func viewDidAppear(animated: Bool) {
        // If there's no day object for today then let's move to the goal setting screen
//        let today = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
//        let day: Day
        let segueIdentifier: String
//        if let fetchedDay = (try? context.executeFetchRequest(Day.fetchRequest(for: today)))?.first as? Day {
//            day = fetchedDay
//            segueIdentifier = WelcomeViewController.toHomeSegueIdentifier
//        } else {
//            day = Day(on: context, with: today)
            segueIdentifier = WelcomeViewController.toGoalsSegueIdentifier
//        }

        dispatch(after: 1) { [weak self] in
            // Perform segue
            self?.performSegueWithIdentifier(segueIdentifier, sender: nil)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if var goalController = segue.destinationViewController as? GoalsViewController,
            let today = NSDate().dayDateComponents().date {
            let day = ((try? context.executeFetchRequest(Day.fetchRequest(for: today)))?.first as? Day) ?? Day(on: context, with: today) 
            goalController.prepare(with: context)
            goalController.day = day
        } else if var homeController = segue.destinationViewController as? HomeViewController {
            homeController.prepare(with: context)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func wecomeStringForTime() -> String {
        let calendar = NSCalendar.currentCalendar()

        let now = NSDate()

        guard let noon = calendar.dateBySettingHour(12, minute: 0, second: 0, ofDate: now, options: NSCalendarOptions()),
            let evening = calendar.dateBySettingHour(17, minute: 0, second: 0, ofDate: now, options: NSCalendarOptions()) else {
                return NSLocalizedString("Welcome", comment: "No Date String")
        }

        let welcomeString: String

        if now.compare(noon) == .OrderedAscending {
            welcomeString = NSLocalizedString("Good Morning", comment: "Morning Welcome String")
        } else if now.compare(evening) == .OrderedAscending {
            welcomeString = NSLocalizedString("Good Afternoon", comment: "Afternoon Welcome String")
        } else {
            welcomeString = NSLocalizedString("Good Evening", comment: "Evening Welcome String")
        }
        return welcomeString
    }

}
