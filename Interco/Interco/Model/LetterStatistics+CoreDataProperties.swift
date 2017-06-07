//
//  LetterStatistics+CoreDataProperties.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 03.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LetterStatistics {

    @NSManaged var letter: String?
    @NSManaged var asked_letter: NSNumber?
    @NSManaged var asked_memo: NSNumber?
    @NSManaged var asked_meaning: NSNumber?
    @NSManaged var correct_letter: NSNumber?
    @NSManaged var correct_meaning: NSNumber?
    @NSManaged var correct_memo: NSNumber?

}
