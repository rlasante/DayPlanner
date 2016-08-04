//
//  UIView+Animations.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/10/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit

extension UIView {

}

extension UIViewAnimationCurve {
    func asOption() -> UIViewAnimationOptions {
        switch self {
        case .EaseIn:
            return .CurveEaseIn
        case .EaseInOut:
            return .CurveEaseInOut
        case .EaseOut:
            return .CurveEaseOut
        case .Linear:
            return .CurveLinear
        }
    }
}