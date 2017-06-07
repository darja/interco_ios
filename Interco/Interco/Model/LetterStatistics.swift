//
//  LetterStatistics.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 03.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import Foundation
import CoreData

@objc(LetterStatistics)
class LetterStatistics: NSManagedObject {

    internal func reset(letter: String) {
        self.letter = letter
        reset()
    }
    
    internal func reset() {
        asked_meaning = 0
        asked_memo = 0
        asked_letter = 0
        
        correct_meaning = 0
        correct_memo = 0
        correct_letter = 0
    }
    
    override var description: String {
        return "LetterStatistics (letter: \(letter)"
    }
}
