//
//  ViewController.swift
//  Flashcards
//
//  Created by Peter Shelley on 2/8/20.
//  Copyright © 2020 Peter Shelley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        optionA.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        optionB.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        optionC.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        correctLabel.isHidden = true
        incorrectLabel.isHidden = true
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        self.questionLabel.isHidden = !self.questionLabel.isHidden
    }
    
    @IBAction func selectOptionA(_ sender: Any) {
        if optionA.currentTitle==answerLabel.text {
            questionLabel.isHidden = true
            correctLabel.isHidden = false
            incorrectLabel.isHidden = true
        } else {
            incorrectLabel.isHidden = false
            correctLabel.isHidden = true
            questionLabel.isHidden = false
        }
    }
    
    @IBAction func selectOptionB(_ sender: Any) {
        if optionB.currentTitle==answerLabel.text {
            questionLabel.isHidden = true
            correctLabel.isHidden = false
            incorrectLabel.isHidden = true
        } else {
            incorrectLabel.isHidden = false
            correctLabel.isHidden = true
            questionLabel.isHidden = false
        }
    }
    
    @IBAction func selectOptionC(_ sender: Any) {
        if optionC.currentTitle==answerLabel.text {
            questionLabel.isHidden = true
            correctLabel.isHidden = false
            incorrectLabel.isHidden = true
        } else {
            incorrectLabel.isHidden = false
            correctLabel.isHidden = true
            questionLabel.isHidden = false
        }
    }
    
}

