//
//  DataProvider.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 01.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import Foundation

public class DataProvider {
    let symbols: [Symbol]
    
    public init() {
        symbols = DataProvider.createSymbols()
    }
    
    private static func createSymbols() -> [Symbol] {
        return [
            Symbol(letter: "a", memo: "Alpha", morseCode: [1, 2], morseMemos: ["al-FA"]),
            Symbol(letter: "b", memo: "Bravo", morseCode: [2, 1, 1, 1], morseMemos: ["YEAH! *clap* *clap* *clap* (applause)", "BE a good boy"]),
            Symbol(letter: "c", memo: "Charlie", morseCode: [], morseMemos: [""]),
            Symbol(letter: "d", memo: "Delta", morseCode: [], morseMemos: [""]),
            Symbol(letter: "e", memo: "Eco", morseCode: [], morseMemos: [""]),
            Symbol(letter: "f", memo: "Foxtrot", morseCode: [], morseMemos: [""]),
        ]
    }
}