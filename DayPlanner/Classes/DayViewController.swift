//
//  DayViewController.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/7/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit
import CoreData

class DayViewController: UIViewController, ContextConfigurable {
    var context: NSManagedObjectContext! {
        didSet {
            fetchDay()
        }
    }
    var date: NSDate! {
        didSet {
            fetchDay()
        }
    }
    private var day: Day! {
        didSet {
            configureGoals()
        }
    }

    @IBOutlet weak var goalsView: UIStackView!
    @IBOutlet weak var tasksView: UIStackView!
    @IBOutlet weak var thoughtsView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureGoals()
    }

    func fetchDay() {
        guard let context = context, date = date where day == nil else { return }
        do {
            guard let day = try context.executeFetchRequest(Day.fetchRequest(for: date)).first as? Day else {
                self.day = Day(on: context, with: date)
                return
            }
            self.day = day
        } catch {
            assertionFailure("We were unable to fetch or create a day object")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if var goalController = segue.destinationViewController as? GoalsViewController {
            goalController.day = day
            goalController.prepare(with: context)
        }
    }

    func configureGoals() {
        guard let day = day, let goalsView = goalsView else {
            return
        }
        for view in goalsView.subviews {
            view.removeFromSuperview()
        }

        let sortedGoals = day.goals.sort { (firstGoal, secondGoal) -> Bool in
            let priorityOrder = firstGoal.priority >= secondGoal.priority
            let dateOrdering = firstGoal.creationDate.compare(secondGoal.creationDate) == .OrderedDescending
            return priorityOrder && dateOrdering
        }
        for goal in sortedGoals {
            let goalLabel = UILabel()
            goalLabel.text = goal.text
            goalsView.addArrangedSubview(goalLabel)
        }

        if sortedGoals.count == 0 {
            goalsView.setNeedsLayout()
        }
    }
}
