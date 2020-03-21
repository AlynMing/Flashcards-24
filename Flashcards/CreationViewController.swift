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
    @IBOutlet var questionText: UITextField!
    @IBOutlet var answerText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let qText = questionText.text
        let aText = answerText.text
        flashcardController.updateFlashcard(q: qText!,
                                            a: aText!)
        dismiss(animated: true)
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
