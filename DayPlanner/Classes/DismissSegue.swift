//
//  DismissSegue.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 8/2/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit

class DismissSegue: UIStoryboardSegue {

    override func perform() {
        guard let presentingController = sourceViewController.presentingViewController else {
            return
        }
        presentingController.dismissViewControllerAnimated(true, completion: nil)
    }

}
