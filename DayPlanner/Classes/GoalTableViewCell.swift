//
//  GoalTableViewCell.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/9/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
