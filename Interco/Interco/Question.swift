//
//  Question.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 02.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import Foundation

public enum QuestionType: Int {
    case FlagLetter = 0
    case FlagMemo = 1
    case FlagMeaning = 2
}

public class Question {
    static let TYPES_COUNT = 3
    
    let type: QuestionType
    let answers: [Symbol]
    let correctIndex: Int
    private let answerToString: (Symbol) -> String
    
    init(type: QuestionType, answers: [Symbol], correctIndex: Int) {
        self.type = type
        self.answers = answers
        self.correctIndex = correctIndex
        
        switch (type) {
        case .FlagLetter: answerToString = { String($0.letter).uppercaseString }
        case .FlagMeaning: answerToString = { $0.meaning }
        case .FlagMemo: answerToString = { $0.memo }
        }
    }
    
    var questionFlag: String {
        get {
            return answers[correctIndex].flag
        }
    }
    
    public func getAnswerString(index: Int) -> String {
        return answerToString(answers[index])
    }
}