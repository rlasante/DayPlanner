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
    private var day: Day!

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
