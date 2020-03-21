//
//  ViewController.swift
//  Flashcards
//
//  Created by Peter Shelley on 2/8/20.
//  Copyright © 2020 Peter Shelley. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readSavedFlashcards()
        if flashcards.count==0{
         updateFlashcard(q: "What is the capital of Brazil?", a: "Brasilia")
        } else {
            updateLabels()
            updatePrevNextButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        self.questionLabel.isHidden = !self.questionLabel.isHidden
    }
    
    func updateFlashcard(q: String, a: String) {
        let flashcardV = Flashcard(question: q, answer: a)
        answerLabel.text = flashcardV.answer
        questionLabel.text = flashcardV.question
        flashcards.append(flashcardV)
        currentIndex = flashcards.count-1
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcard(s).")
        print("Our current index is \(flashcards.count-1)")
        updatePrevNextButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardController = self
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex+=1
        updateLabels()
        updatePrevNextButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex-=1
        updateLabels()
        updatePrevNextButtons()
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
        answerLabel.text = flashcards[currentIndex].answer
        questionLabel.text = flashcards[currentIndex].question
        self.questionLabel.isHidden=false
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults!")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
}

