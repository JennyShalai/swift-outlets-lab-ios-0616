//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.winLabel.isHidden = true
    }
    
    @IBAction func redTapped(_ sender: AnyObject) {
        print("red")
        simonSaysGame.guessRed()
        updateWinLable()
    }
    
    @IBAction func greenTapped(_ sender: AnyObject) {
        print("green")
        simonSaysGame.guessGreen()
        updateWinLable()
    }
    
    @IBAction func yellowTapped(_ sender: AnyObject) {
        print("yellow")
        simonSaysGame.guessYellow()
        updateWinLable()
    }
    
    @IBAction func blueTapped(_ sender: AnyObject) {
        print("blue")
        simonSaysGame.guessBlue()
        updateWinLable()
    }
    
    func updateWinLable() {
        if simonSaysGame.wonGame() {
            self.winLabel.isHidden = false
            self.winLabel.text = "YOU WIN!"
        }
        
        if (simonSaysGame.chosenColors.count == simonSaysGame.patternToMatch.count) && (!simonSaysGame.wonGame()) {
            self.winLabel.isHidden = false
            self.winLabel.text = "NOPE, TRY AGAIN!"
        }
    }
    
}


// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
