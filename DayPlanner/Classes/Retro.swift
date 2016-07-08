//
//  Retro.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class Retro: NSManagedObject, SubContent, ThoughtFactory {

}

extension Retro: ParentConvertable {
    func parentWrapper() -> Parent {
        return .retro(retro: self)
    }
}

protocol OnRetro {
    var retro: Retro { get set }
}

protocol OnOptionalRetro {
    var retro: Retro? { get set }
}
