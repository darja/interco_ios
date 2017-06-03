//
//  Symbol.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 01.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import Foundation

class Symbol {
    let letter: Character
    let flag: String
    let memo: String
    let meaning: String
    let morseCode: [Int]
    let morseMemos: [String]
    
    init(letter: Character, memo: String, morseCode: [Int], morseMemos: [String]) {
        self.letter = letter
        self.flag = "\(letter)"
        self.memo = memo
        self.meaning = NSLocalizedString("\(letter)_meaning", comment: "Letter \(letter) meaning)")
        self.morseCode = morseCode
        self.morseMemos = morseMemos
    }
    
    internal static var getLetter = {
        (symbol: Symbol) -> String in
        return String(symbol.letter).uppercaseString
    }
    
    internal static var getMemo = {
        (symbol: Symbol) -> String in
        return symbol.memo
    }
    
    internal static var getMeaning = {
        (symbol: Symbol) -> String in
        return symbol.meaning
    }

}