//
//  ColorGuessModel.swift
//  ColorGuess
//
//  Created by Anthony Gonzalez on 7/30/19.
//  Copyright © 2019 Anthony Gonzalez. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
//Extension that breaks a UIColor type down into its RGB values as CGFloats.


class ColorGuessModel {
    
    var myCurrentScore = 0
    var myHighScore = 0
    var myCurrentColor: UIColor //Must change as the game goes on but also must have a current value so that the user can guess it.
    var myCurrentClosestPrimaryColor: UIColor //Changes based on myCurrentColor
    
    
    
    func changeColor() -> UIColor {
        myCurrentColor = ColorGuessModel.randomColor()
        myCurrentClosestPrimaryColor = ColorGuessModel.myClosestColor(colorInput: myCurrentColor)
        return myCurrentColor
    }
    //This function changes the color of the myCurrentColor variable and the closest primary so it can be something new on each press of a button.
    
    
    
    static func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        let randomizedColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
        return (randomizedColor)
    }
    //This is the function that generates a random color as well as the associated "closest" color.
    
    
    
    static func myClosestColor (colorInput: UIColor) -> UIColor {
        let myCurrentRed = colorInput.rgba.red
        let myCurrentGreen = colorInput.rgba.green
        let myCurrentBlue = colorInput.rgba.blue
        let closestPrimaryColor: UIColor
        if max(myCurrentRed, myCurrentGreen, myCurrentBlue) == myCurrentRed {
            closestPrimaryColor = UIColor.red
        } else if max(myCurrentRed, myCurrentGreen, myCurrentBlue) == myCurrentGreen {
            closestPrimaryColor = UIColor.green
        } else {
            closestPrimaryColor = UIColor.blue
        }
        return closestPrimaryColor
    }
    //Breaks myCurrentColor into RGB CGFloats and compares each value to determine what the closest primary color is.
    
    
    func myClosestColorGuess (guessOption: UIColor) -> Bool {
        if myCurrentClosestPrimaryColor == guessOption {
            myCurrentScore += 1
            return true
        } else {
            return false
        }
    }
    
    
    
    init(){
        self.myCurrentColor = ColorGuessModel.randomColor()
        self.myCurrentClosestPrimaryColor = ColorGuessModel.myClosestColor(colorInput: myCurrentColor)
    }
}
