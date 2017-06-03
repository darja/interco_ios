//
//  QuizViewController.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 01.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    let dataProvider = DataProvider()
    var question: Question?
    
    let normalColor =    UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
    let correctColor =   UIColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1)
    let incorrectColor = UIColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1)

    @IBOutlet var questionImage: UIImageView!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!
    
    var answers: [UIButton!] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answers = [answer1, answer2, answer3, answer4]
        showNextQuestion()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAnswerSelected(sender: UIButton) {
        for i in 0...answers.count - 1 {
            if answers[i] == sender {
                if i != question?.correctIndex {
                    answers[i].backgroundColor = incorrectColor
                }
                answers[question!.correctIndex].backgroundColor = correctColor
                break
            }
        }
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 2)
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, triggerTime),
            dispatch_get_main_queue(),
            {self.showNextQuestion()}
        )
    }
    
    private func showNextQuestion() {
        question = dataProvider.createQuestion()
        
        questionImage.image = UIImage(named: question!.questionFlag)
        for i in 0...answers.count - 1 {
            answers[i].setTitle(question!.getAnswerString(i), forState: .Normal)
            answers[i].backgroundColor = normalColor
        }
    }
}

