//
//  Dispatch.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/10/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit

func dispatch(after seconds: Double, on queue: dispatch_queue_t = dispatch_get_main_queue(), block: dispatch_block_t) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC))), queue, block)
}
