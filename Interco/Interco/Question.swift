//
//  Question.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 02.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import Foundation

public class Question {
    public enum Type {
        case FlagLetter, FlagMemo
    }
    
    let type: Type
    let answers: [Symbol]
    let correctIndex: Int
    
    init(type: Type, answers: [Symbol], correctIndex: Int) {
        self.type = type
        self.answers = answers
        self.correctIndex = correctIndex
    }
    
    var questionFlag: String {
        get {
            return answers[correctIndex].flag
        }
    }
    

}