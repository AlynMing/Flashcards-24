//
//  ViewController.swift
//  Flashcards
//
//  Created by Peter Shelley on 2/8/20.
//  Copyright © 2020 Peter Shelley. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String!
    var answer: String!
    var incorrect1: String!
    var incorrect2: String!
}

class ViewController: UIViewController {

    var creationController = CreationViewController.self
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var card: UIView!
    @IBOutlet var opt1: UIButton!
    @IBOutlet var opt2: UIButton!
    @IBOutlet var opt3: UIButton!
    @IBOutlet var deleteButton: UIButton! = nil
    var correctButton: UIButton!
    
    var flashcardToBeDeleted: Flashcard!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius=20.0
        answerLabel.layer.cornerRadius=20.0
        answerLabel.clipsToBounds=true
        questionLabel.layer.cornerRadius=20.0
        questionLabel.clipsToBounds=true
        card.layer.shadowRadius=15.0
        card.layer.shadowOpacity=0.2
        
        opt1.layer.cornerRadius=20.0
        opt1.layer.borderWidth=3.0
        opt1.layer.borderColor=#colorLiteral(red: 0.2572371662, green: 0.7545303702, blue: 0.9694395661, alpha: 1)
        opt2.layer.cornerRadius=20.0
        opt2.layer.borderWidth=3.0
        opt2.layer.borderColor=#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        opt3.layer.cornerRadius=20.0
        opt3.layer.borderWidth=3.0
        opt3.layer.borderColor=#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        card.sizeToFit()
    
        readSavedFlashcards()
        if flashcards.count==0{
            currentIndex=0
            flashcards.append(Flashcard(question: "This is a sample flashcard.", answer: "Option 1", incorrect1: "Option 2", incorrect2: "Option 3"))
            updateFlashcard(q: "This is a sample flashcard.", a: "Option 1", i1: "Option 2", i2: "Option 3", isExisting: true)
        } else {
            updateLabels()
            updatePrevNextButtons()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1
            self.card.transform = CGAffineTransform.identity
        })
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.questionLabel.isHidden = !self.questionLabel.isHidden
        })
    }
    
    
    @IBAction func didTapOpt1(_ sender: Any) {
        if opt1==correctButton{
            flipFlashcard()
        } else {
            opt1.isHidden=true
            questionLabel.isHidden=false
        }
    }
    
    @IBAction func didTapOpt2(_ sender: Any) {
        if opt2==correctButton{
            flipFlashcard()
        } else {
            opt2.isHidden=true
            questionLabel.isHidden=false
        }
    }
    
    @IBAction func didTapOpt3(_ sender: Any) {
        if opt3==correctButton{
            flipFlashcard()
        } else {
            opt3.isHidden=true
            questionLabel.isHidden=false
        }
    }
    
    
    func updateFlashcard(q: String, a: String, i1: String, i2: String, isExisting: Bool) {
        let flashcardV = Flashcard(question: q, answer: a, incorrect1: i1, incorrect2: i2)
        if isExisting{
            flashcards[currentIndex]=flashcardV
        } else {
            flashcards.append(flashcardV)
            currentIndex = flashcards.count-1
        }
        updatePrevNextButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardController = self
        if segue.identifier=="EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
            creationController.initialIncorrect1 = opt2.titleLabel!.text
            creationController.initialIncorrect2 = opt3.titleLabel!.text
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex+=1
        updatePrevNextButtons()
        animateCardOutLeft()
    }
    
    func animateCardOutLeft(){
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -400.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardInFromRight()
        })
    }
    
    func animateCardInFromRight(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 400.0, y: 0.0)
        UIView.animate(withDuration: 0.2){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex-=1
        updatePrevNextButtons()
        animateCardOutRight()
    }
    
    func animateCardOutRight(){
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 400.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardInFromLeft()
        })
    }
    
    func animateCardInFromLeft(){
        card.transform = CGAffineTransform.identity.translatedBy(x: -400.0, y: 0.0)
        UIView.animate(withDuration: 0.2){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func updatePrevNextButtons(){
        if currentIndex==flashcards.count-1{
            nextButton.isEnabled=false
        } else {
            nextButton.isEnabled=true
        }
        if currentIndex==0{
            prevButton.isEnabled=false
        } else {
            prevButton.isEnabled=true
        }
    }
    
    func updateLabels(){
        opt1.isHidden=false
        opt2.isHidden=false
        opt3.isHidden=false
        answerLabel.text = flashcards[currentIndex].answer
        questionLabel.text = flashcards[currentIndex].question
        let currentFlashcard = flashcards[currentIndex]
        let buttons = [opt1, opt2, opt3].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.incorrect2, currentFlashcard.incorrect1].shuffled()
        for (button, answer) in zip(buttons, answers){
            button?.setTitle(answer, for: .normal)
            if answer == currentFlashcard.answer {
                correctButton=button
            }
        }
        self.questionLabel.isHidden=false
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        flashcardToBeDeleted = flashcards[currentIndex]
        flashcards.remove(at: currentIndex)
        if currentIndex>flashcards.count-1{
            currentIndex = flashcards.count-1
        }
        if currentIndex<0{
            currentIndex=0
            performSegue(withIdentifier: "creationSegue", sender: self)
            return
        }
        updateLabels()
        updatePrevNextButtons()
        saveAllFlashcardsToDisk()
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question!, "answer": card.answer!, "incorrect1": card.incorrect1!, "incorrect2": card.incorrect2!]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults!")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"], answer: dictionary["answer"], incorrect1: dictionary["incorrect1"], incorrect2: dictionary["incorrect2"])
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
}

