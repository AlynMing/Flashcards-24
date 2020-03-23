//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Peter Shelley on 3/3/20.
//  Copyright © 2020 Peter Shelley. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardController: ViewController!
    var initialQuestion: String?
    var initialAnswer: String?
    var initialIncorrect1: String?
    var initialIncorrect2: String?
    @IBOutlet var questionText: UITextField!
    @IBOutlet var answerText: UITextField!
    @IBOutlet var incorrectOption1: UITextField!
    @IBOutlet var incorrectOption2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view.
        questionText.text = initialQuestion
        answerText.text = initialAnswer
        incorrectOption1.text = initialIncorrect1
        incorrectOption2.text = initialIncorrect2
    }
    @IBAction func didTapOnCancel(_ sender: Any) {
        if flashcardController.flashcardToBeDeleted != nil{
            flashcardController.flashcards.append(flashcardController.flashcardToBeDeleted)
        }
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        if questionText.text==nil || questionText.text!.isEmpty
            || answerText.text==nil || answerText.text!.isEmpty
            || incorrectOption1.text==nil || incorrectOption1.text!.isEmpty
            || incorrectOption2.text==nil || incorrectOption2.text!.isEmpty {
            let missingTextAlert = UIAlertController(title: "Missing Text", message: "You need to enter a question and three answer choices.", preferredStyle: .alert)
            let OKAlert = UIAlertAction(title: "Ok", style: .default)
            missingTextAlert.addAction(OKAlert)
            present(missingTextAlert, animated: true)
        } else {
            flashcardController.updateFlashcard(q: questionText.text!,
                                            a: answerText.text!,
                                            i1: incorrectOption1.text!,
                                            i2: incorrectOption2.text!,
                                            isExisting: initialQuestion != nil)
            dismiss(animated: true)}
    }
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        CreationViewController.flashcardController = self
    }
    */

}
