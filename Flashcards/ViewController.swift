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
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        self.questionLabel.isHidden = !self.questionLabel.isHidden
    }
}

