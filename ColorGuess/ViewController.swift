//
//  ViewController.swift
//  ColorGuess
//
//  Created by Anthony Gonzalez on 7/30/19.
//  Copyright © 2019 Anthony Gonzalez. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var debugColor: UILabel! //Debug tool. Hidden.
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    
    var ColorGuessModelInstance = ColorGuessModel() //Instance of ColorGuessModel class. Can be used to run functions, etc.
    
    
    
    @IBAction func newGame(_ sender: UIButton) {
        [gameOverLabel, newGameButton].forEach({$0?.isHidden = true})
        [redButton, greenButton, blueButton].forEach( { $0?.isEnabled = true })
        labelText.isHidden = false
        colorView.backgroundColor = ColorGuessModelInstance.changeColor()
        highscoreLabel.text = "Highscore: \(max(ColorGuessModelInstance.myHighScore, ColorGuessModelInstance.myCurrentScore))"
        ColorGuessModelInstance.myCurrentScore = 0
        currentScoreLabel.text = "Current Score: 0"
    }
    
    
    
    @IBAction func colorGuessAnswer(_ sender: UIButton) {
        var guessOption: UIColor
        switch sender.tag { //Switches based on button tags.
        case 0: guessOption = UIColor.red
        case 1: guessOption = UIColor.green
        case 2: guessOption = UIColor.blue
        default: guessOption = UIColor.black
        }
        
        if ColorGuessModelInstance.myClosestColorGuess(guessOption: guessOption) {
            self.currentScoreLabel.text = "Current Score: \(ColorGuessModelInstance.myCurrentScore)"
            self.colorView.backgroundColor = ColorGuessModelInstance.changeColor()
        } else {
            labelText.isHidden = true
            [gameOverLabel, newGameButton].forEach({$0?.isHidden = false})
            [redButton,greenButton,blueButton].forEach({$0?.isEnabled = false})
        }
    }
    
    
    
    @IBAction func showPrimaryAnswer(_ sender: UIButton) {
        debugColor.text = """
        A: \(ColorGuessModelInstance.myCurrentColor) P:\(ColorGuessModelInstance.myCurrentClosestPrimaryColor)
        """
    }
    //Debugging tool to show the actual value and primary value. Hidden
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //I use a dark BG so this makes the statusbar white, for clarity.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.backgroundColor = ColorGuessModelInstance.myCurrentColor
        colorView.layer.cornerRadius = colorView.frame.size.width/2
        colorView.clipsToBounds = true //Lines 85 and 86 are used to adjust the corners so that colorView is a circle.
        
        colorView.layer.borderColor = UIColor.white.cgColor
        colorView.layer.borderWidth = 5.0 //Adds a a border to the colorView.
    }
}
