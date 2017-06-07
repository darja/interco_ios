//
//  DataProvider.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 01.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import Foundation
import Darwin

public class DataProvider {
    let symbols: [Symbol]
    var lastAskedIndices = [Int]()
    
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
            Symbol(letter: "g", memo: "Golf", morseCode: [], morseMemos: [""]),
            Symbol(letter: "h", memo: "Hotel", morseCode: [], morseMemos: [""]),
        ]
    }
    
    public func createQuestion() -> Question {
        var answersIndices = [Int]()
        
        let symbolsCount = UInt32(symbols.count)
        var symbolIndex: Int
        let answersCount = 4
        let historySize = 5
        
        if lastAskedIndices.count > historySize {
            lastAskedIndices.removeFirst()
        }
        
        var correctLetterIndex = -1
        repeat {
            correctLetterIndex = Int(arc4random_uniform(symbolsCount))
        } while (lastAskedIndices.contains(correctLetterIndex))
        lastAskedIndices.append(correctLetterIndex)
        
        for _ in 0...answersCount - 1 {
            repeat {
                symbolIndex = Int(arc4random_uniform(symbolsCount))
            } while answersIndices.contains(symbolIndex) || correctLetterIndex == symbolIndex
            answersIndices.append(symbolIndex)
        }
        
        let correctAnswerIndex = Int(arc4random_uniform(UInt32(answersCount)))
        answersIndices.insert(correctLetterIndex, atIndex: correctAnswerIndex)
        
        var answers = [Symbol]()
        for i in 0...answersCount {
            answers.append(symbols[answersIndices[i]])
        }
        
        let typeIndex = Int(arc4random_uniform(UInt32(Question.TYPES_COUNT)))
        let type = QuestionType(rawValue: typeIndex)
        
        return Question(type: type!, answers: answers, correctIndex: correctAnswerIndex)
    }
}