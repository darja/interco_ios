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
    
    @IBAction func onAnswerSelected(sender: AnyObject) {
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        question = dataProvider.createQuestion()
        
        questionImage.image = UIImage(named: question!.questionFlag)
        for i in 0...answers.count - 1 {
            answers[i].setTitle(question!.getAnswerString(i), forState: .Normal)
        }
    }
}

