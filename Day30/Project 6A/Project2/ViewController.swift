//
//  ViewController.swift
//  Project2
//
//  Created by Muhammad Usman Tatla on 18/06/2019.
//  Copyright © 2019 Zafus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia","france","germany","ireland",
                      "italy","monaco","nigeria",
                      "poland","russia","spain","uk","us"]
        askQuestion()
        
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + "  Score: \(score)"
        
        totalQuestionsAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var additionalMessage = ""
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            additionalMessage = "That's the flag of \(countries[sender.tag]). "
            score -= 1
        }
        
        if totalQuestionsAsked == 10 {
            let alertController = UIAlertController(title: "It's Over", message: "Your total score is \(score)/10. Want to restart?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: .default){ action in
                self.score = 0
                self.totalQuestionsAsked = 0
                self.askQuestion()
            })
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            let alertController = UIAlertController(title: title, message: additionalMessage + "Your score is \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
}


