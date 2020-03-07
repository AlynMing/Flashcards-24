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
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        self.questionLabel.isHidden = !self.questionLabel.isHidden
    }
    
    func updateFlashcard(question: String?, answer: String?) {
        answerLabel.text = answer
        questionLabel.text = question
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardController = self
    }
    
}

