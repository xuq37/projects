//
//  NMViewController.swift
//  Xu_Jack_Memory
//
//  Created by Period Four on 2018-04-27.
//  Copyright © 2018 Period Four. All rights reserved.
//

import UIKit

class NMViewController: UIViewController {
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var Player1ScoreLable: UILabel!
    @IBOutlet weak var Player1Lable: UILabel!
    @IBOutlet weak var Player2ScoreLable: UILabel!
    @IBOutlet weak var TimeLable: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var GiveUpBtn: UIButton!
    @IBOutlet weak var Player2Lable: UILabel!
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var btn16: UIButton!
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var ScoreSymbol: UILabel!
    //Create variables for the shuffle function.
    var deck1: [UIImage] = [#imageLiteral(resourceName: "Beauty"),#imageLiteral(resourceName: "fitty"),#imageLiteral(resourceName: "Happy"),#imageLiteral(resourceName: "Lazy"),#imageLiteral(resourceName: "MrW"),#imageLiteral(resourceName: "LadyW"),#imageLiteral(resourceName: "Sunny"),#imageLiteral(resourceName: "LittleGray"),#imageLiteral(resourceName: "Beauty"),#imageLiteral(resourceName: "fitty"),#imageLiteral(resourceName: "Happy"),#imageLiteral(resourceName: "Lazy"),#imageLiteral(resourceName: "MrW"),#imageLiteral(resourceName: "LadyW"),#imageLiteral(resourceName: "LittleGray"),#imageLiteral(resourceName: "Sunny")]
    var deck2: [UIImage] = []
    //Set the images of the buttons to the the cover image.
    let coverImage: UIImage = #imageLiteral(resourceName: "images (1)")
    //Create an button array for the matching function.
    var btnArray: [UIButton] = []
    //Create a bool variable for the matching function.
    var isItTheSecondImage = false
    //Create a number to repersent each button.
    var btnNumber = 0
    //Create a variable to represent the score.
    var score = 0
    //Create a variable to represent the number of consecutive matches.
    var numberOfContinuos = 0
    //Create a variable to represent which mode is selected.
    var modenum = 0
    //Set the total time of the time mode to 70 seconds.
    var totalTime = 70
    //Create a variable for the timer function.
    var time = Timer()
    //Create variables for the two players in the double player mode.
    var player1Score = 0
    var player2Score = 0
    //Create a variables to tell it is in which player's turn.
    var whichPlayer = true
    //Create a shuffle function
    func shuffle() {
        //Make the upper limit for the random number.
        var upperlimit: UInt32 = 16
        //Create a variable for the random number.
        var random: Int
        //Make the random tansformation 16 times so that all the images in the deck2 array are in random order.
        for _ in 1...16 {
            random = Int(arc4random_uniform(upperlimit))
            deck2.append(deck1[random])
            deck1.remove(at: random)
            upperlimit -= 1
        }
    }
    //Create a counter function for the timer mode
    @objc func couter(){
        //For every second, the time  decrease by one.
        totalTime -= 1
        TimeLable.text = String(totalTime)
        //If there is no time left, stop counting down and show all the answers.
        if totalTime == 0{
            time.invalidate()
            newGameBtn.isHidden = false
            btn1.setImage(deck2[0], for: UIControlState.normal)
            btn2.setImage(deck2[1], for: UIControlState.normal)
            btn3.setImage(deck2[2], for: UIControlState.normal)
            btn4.setImage(deck2[3], for: UIControlState.normal)
            btn5.setImage(deck2[4], for: UIControlState.normal)
            btn6.setImage(deck2[5], for: UIControlState.normal)
            btn7.setImage(deck2[6], for: UIControlState.normal)
            btn8.setImage(deck2[7], for: UIControlState.normal)
            btn9.setImage(deck2[8], for: UIControlState.normal)
            btn10.setImage(deck2[9], for: UIControlState.normal)
            btn11.setImage(deck2[10], for: UIControlState.normal)
            btn12.setImage(deck2[11], for: UIControlState.normal)
            btn13.setImage(deck2[12], for: UIControlState.normal)
            btn14.setImage(deck2[13], for: UIControlState.normal)
            btn15.setImage(deck2[14], for: UIControlState.normal)
            btn16.setImage(deck2[15], for: UIControlState.normal)
            //Disable all the buttons when the time runs out. and enable the new game button.
            GiveUpBtn.isEnabled = false
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            newGameBtn.isHidden = false
            btn1.isHidden = false
            btn2.isHidden = false
            btn3.isHidden = false
            btn4.isHidden = false
            btn5.isHidden = false
            btn6.isHidden = false
            btn7.isHidden = false
            btn8.isHidden = false
            btn9.isHidden = false
            btn10.isHidden = false
            btn11.isHidden = false
            btn12.isHidden = false
            btn13.isHidden = false
            btn14.isHidden = false
            btn15.isHidden = false
            btn16.isHidden = false
        }
        //For the first 50 seconds, 1 mark is taken off as every second passes.
        if (70 - totalTime) <= 50 {
            score = 100 - 1*(70 - totalTime)
        //For the next 10 seconds, 2 marks are taken off as every second passes.
        } else if (70 - totalTime) > 50 && (70 - totalTime) <= 60 {
            score = 100 - 50 - 2 * (70 - totalTime - 50)
        //For the last 10 seconds, 3 marks are taken off as every second passes.
        } else if (70 - totalTime) > 60 && (70 - totalTime) <= 70 {
            score = 100 - 70 - 3 * (70 - totalTime - 60)
        }
        //Show the score in the score lable for every second.
        Score.text = String(score)
    }
    //Create the matching function.
    func match()  {
    //Enable all the buttons after the 1 second delay.
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
        btn5.isEnabled = true
        btn6.isEnabled = true
        btn7.isEnabled = true
        btn8.isEnabled = true
        btn9.isEnabled = true
        btn10.isEnabled = true
        btn11.isEnabled = true
        btn12.isEnabled = true
        btn13.isEnabled = true
        btn14.isEnabled = true
        btn15.isEnabled = true
        btn16.isEnabled = true
    //If the single player mode is selected, run the following rule.
        if modenum == 1{
        //If it is the first clicked button, make the swicth turn to false to tell that the next button is the second clicked button.
           if isItTheSecondImage == false {
               isItTheSecondImage = true
               //Disable this button to force the player not clicking the same button twice.
               btnArray[0].isEnabled = false
           //If it is the second image clicked, run the following rule.
           } else if isItTheSecondImage == true {
               //Enable the buttons clicked before.
               btnArray[0].isEnabled = true
               btnArray[1].isEnabled = true
               //If the buttons clicked are the same, run the following rule.
               if btnArray[0].image(for: UIControlState.normal) == btnArray[1].image(for: UIControlState.normal) {
                //Set the images back to the cover images for the two buttons clicked.
                   btnArray[0].setImage(coverImage, for: UIControlState.normal)
                   btnArray[1].setImage(coverImage, for: UIControlState.normal)
                //Hide these two buttons.
                   btnArray[0].isHidden = true
                   btnArray[1].isHidden = true
                //Reset the button array to an empty one
                   btnArray.removeAll()
                //For every success match, the number of concecutive increase by one
                   numberOfContinuos += 1
                //Calculate the score base on the number of concecutive.
                   score += Int(pow(2, Double(numberOfContinuos - 1)))
                //If the two buttons are different, run the following rule.
               } else if btnArray[0].image(for: UIControlState.normal) != btnArray[1].image(for: UIControlState.normal) {
                //Enable the fits button clicked.
                   btnArray[0].isEnabled = true
                //set the images back to the cover image.(flip back)
                   btnArray[0].setImage(coverImage, for: UIControlState.normal)
                   btnArray[1].setImage(coverImage, for: UIControlState.normal)
                //reset the button array for the next time.
                   btnArray.removeAll()
                //Set the number of consecutive back to 0.
                   numberOfContinuos = 0
               }
            //show the score in the lable.
               Score.text = String(score)
            //swicth back so that to show the next image is the first clicked button.
               isItTheSecondImage = false
            //If all the pairs are matched, game over, and new game button show up.
               if btn1.isHidden == true && btn2.isHidden == true && btn3.isHidden == true && btn4.isHidden == true && btn5.isHidden == true && btn6.isHidden == true && btn7.isHidden == true && btn8.isHidden == true && btn9.isHidden == true && btn10.isHidden == true && btn11.isHidden == true && btn12.isHidden == true && btn13.isHidden == true && btn14.isHidden == true && btn15.isHidden == true && btn16.isHidden == true {
                newGameBtn.isHidden = false
               }
           }
            //If it is in the time count down mode, run the following rule
        } else if modenum == 2 {
            //If it is the first clicked button, make the swicth turn to false to tell that the next button is the second clicked button.
            if isItTheSecondImage == false {
                isItTheSecondImage = true
            //Disable this button to force the player not clicking the same button twice.
                btnArray[0].isEnabled = false
            //If it is the second image clicked, run the following rule.
            } else if isItTheSecondImage == true {
            //Enable the buttons clicked before.
                btnArray[0].isEnabled = true
                btnArray[1].isEnabled = true
                //If the buttons clicked are the same, run the following rule.
                if btnArray[0].image(for: UIControlState.normal) == btnArray[1].image(for: UIControlState.normal) {
                //Set the images back to the cover images for the two buttons clicked.
                    btnArray[0].setImage(coverImage, for: UIControlState.normal)
                    btnArray[1].setImage(coverImage, for: UIControlState.normal)
                //Hide these two buttons.
                    btnArray[0].isHidden = true
                    btnArray[1].isHidden = true
                //Reset the button array for the next time.
                    btnArray.removeAll()
                //If the two buttons are different, run the following rule.
                } else if btnArray[0].image(for: UIControlState.normal) != btnArray[1].image(for: UIControlState.normal) {
                    //enable the first button
                    btnArray[0].isEnabled = true
                    //Flip back the two buttons
                    btnArray[0].setImage(coverImage, for: UIControlState.normal)
                    btnArray[1].setImage(coverImage, for: UIControlState.normal)
                    //Reset the button array for the next time.
                    btnArray.removeAll()
                }
                 //swicth back so that the next image is the first clicked.
                isItTheSecondImage = false
                //If all the characters are matched, stop the timer and show the new game button.
                if btn1.isHidden == true && btn2.isHidden == true && btn3.isHidden == true && btn4.isHidden == true && btn5.isHidden == true && btn6.isHidden == true && btn7.isHidden == true && btn8.isHidden == true && btn9.isHidden == true && btn10.isHidden == true && btn11.isHidden == true && btn12.isHidden == true && btn13.isHidden == true && btn14.isHidden == true && btn15.isHidden == true && btn16.isHidden == true {
                    newGameBtn.isHidden = false
                    time.invalidate()
                }
            }
        //When two player mode is selected, run the following rule
        } else if modenum == 3{
            //If it is the first clicked button, make the swicth turn to false to tell that the next button is the second clicked button.
            if isItTheSecondImage == false {
                isItTheSecondImage = true
                btnArray[0].isEnabled = false
            //If it is the second image clicked, run the following rule.
            } else if isItTheSecondImage == true {
                 //Enable the buttons clicked before.
                btnArray[0].isEnabled = true
                btnArray[1].isEnabled = true
                //If the buttons clicked are the same, run the following rule.
                if btnArray[0].image(for: UIControlState.normal) == btnArray[1].image(for: UIControlState.normal) {
                 //Set the images back to the cover images for the two buttons clicked.
                    btnArray[0].setImage(coverImage, for: UIControlState.normal)
                    btnArray[1].setImage(coverImage, for: UIControlState.normal)
                //Hide these two buttons.
                    btnArray[0].isHidden = true
                    btnArray[1].isHidden = true
                //Reset the button array for the next time.
                    btnArray.removeAll()
                //Number of consecutive matches increase by 1.
                    numberOfContinuos += 1
                //If it is the first player's turn, add score to his(her) lable by the rule.
                    if whichPlayer == true {
                        player1Score += Int(pow(2, Double(numberOfContinuos - 1)))
                //If it is the second player's turn, add score to his(her) lable by the rule.
                    } else if whichPlayer == false {
                        player2Score += Int(pow(2, Double(numberOfContinuos - 1)))
                    }
                //Print their scores on the lables.
                    Player1ScoreLable.text = String(player1Score)
                    Player2ScoreLable.text = String(player2Score)
                 //If the two buttons are different, run the following rule.
                } else if btnArray[0].image(for: UIControlState.normal) != btnArray[1].image(for: UIControlState.normal) {
                //Enable the first clicked button
                    btnArray[0].isEnabled = true
                //Flipe back, set the images back to the cover image.
                    btnArray[0].setImage(coverImage, for: UIControlState.normal)
                    btnArray[1].setImage(coverImage, for: UIControlState.normal)
                //Reset the button array for the next time.
                    btnArray.removeAll()
                //Swicth turns to the other player
                    if whichPlayer == true {
                        whichPlayer = false
                    } else if whichPlayer == false {
                        whichPlayer = true
                    }
                //The number consecutive matches reset to 0.
                    numberOfContinuos = 0
                }
                isItTheSecondImage = false
                //If all the characters are matched, game over, show the new game button.
                if btn1.isHidden == true && btn2.isHidden == true && btn3.isHidden == true && btn4.isHidden == true && btn5.isHidden == true && btn6.isHidden == true && btn7.isHidden == true && btn8.isHidden == true && btn9.isHidden == true && btn10.isHidden == true && btn11.isHidden == true && btn12.isHidden == true && btn13.isHidden == true && btn14.isHidden == true && btn15.isHidden == true && btn16.isHidden == true {
                    newGameBtn.isHidden = false
                }
            }
        }
    }
    //Make a function for the starte button.
    @IBAction func StartBtn(_ sender: Any) {
        //If single player mode is selected, show all the game buttons and show the score lable, give up button. Hide the starte game button.
        if modenum == 1 {
            btn1.isHidden = false
            btn2.isHidden = false
            btn3.isHidden = false
            btn4.isHidden = false
            btn5.isHidden = false
            btn6.isHidden = false
            btn7.isHidden = false
            btn8.isHidden = false
            btn9.isHidden = false
            btn10.isHidden = false
            btn11.isHidden = false
            btn12.isHidden = false
            btn13.isHidden = false
            btn14.isHidden = false
            btn15.isHidden = false
            btn16.isHidden = false
            ScoreSymbol.isHidden = false
            Score.isHidden = false
            startBtn.isHidden = true
            GiveUpBtn.isHidden = false
        //If the count down mode is selected, show all the game buttons, show the score label, set and show the timer, set the start score ton 100. Hide the starte game button. Show the give up button
        } else if modenum == 2 {
            TimeLbl.isHidden = false
            btn1.isHidden = false
            btn2.isHidden = false
            btn3.isHidden = false
            btn4.isHidden = false
            btn5.isHidden = false
            btn6.isHidden = false
            btn7.isHidden = false
            btn8.isHidden = false
            btn9.isHidden = false
            btn10.isHidden = false
            btn11.isHidden = false
            btn12.isHidden = false
            btn13.isHidden = false
            btn14.isHidden = false
            btn15.isHidden = false
            btn16.isHidden = false
            ScoreSymbol.isHidden = false
            Score.isHidden = false
            startBtn.isHidden = true
            GiveUpBtn.isHidden = false
            TimeLable.isHidden = false
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NMViewController.couter), userInfo: nil, repeats: true)
            score = 100
        //If the two player mode is selected, show the twomplayers' score labels, their names. Show the give up  button, hide the start game button.
        } else if modenum == 3 {
            btn1.isHidden = false
            btn2.isHidden = false
            btn3.isHidden = false
            btn4.isHidden = false
            btn5.isHidden = false
            btn6.isHidden = false
            btn7.isHidden = false
            btn8.isHidden = false
            btn9.isHidden = false
            btn10.isHidden = false
            btn11.isHidden = false
            btn12.isHidden = false
            btn13.isHidden = false
            btn14.isHidden = false
            btn15.isHidden = false
            btn16.isHidden = false
            Player1Lable.isHidden = false
            Player2Lable.isHidden = false
            Player1ScoreLable.isHidden = false
            Player2ScoreLable.isHidden = false
            ScoreSymbol.isHidden = true
            Score.isHidden = true
            startBtn.isHidden = true
            GiveUpBtn.isHidden = false
        }
        
    }
    //Set a function for the first game button.
    @IBAction func btn1Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn1.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 0
        btn1.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn1)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
        //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
        //Otherwise, call the match function directly.
        } else {
           match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn2Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn2.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 1
        btn2.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn2)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn3Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn3.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 2
        btn3.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn3)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn4Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn4.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 3
        btn4.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn4)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn5Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn5.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 4
        btn5.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn5)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn6Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn6.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 5
        btn6.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn6)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn7Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn7.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 6
        btn7.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn7)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn8Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn8.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 7
        btn8.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn8)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn9Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn9.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 8
        btn9.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn9)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn10Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn10.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 9
        btn10.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn10)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn11Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn11.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 10
        btn11.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn11)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn12Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn12.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 11
        btn12.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn12)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn13Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn13.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 12
        btn13.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn13)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn14Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn14.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 13
        btn14.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn14)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn15Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn15.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 14
        btn15.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn15)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set a function for the first game button.
    @IBAction func btn16Press(_ sender: Any) {
        //Disable the button until 1 second delay is up.
        btn16.isEnabled = false
        //If it is clicked, set the image to the first image in deck2.
        btnNumber = 15
        btn16.setImage(deck2[btnNumber], for: UIControlState.normal)
        //Add this button to the button array.
        btnArray.append(btn16)
        //Disable all the buttons until the 1 second delay is up.
        if isItTheSecondImage == true {
            btn1.isEnabled = false
            btn2.isEnabled = false
            btn3.isEnabled = false
            btn4.isEnabled = false
            btn5.isEnabled = false
            btn6.isEnabled = false
            btn7.isEnabled = false
            btn8.isEnabled = false
            btn9.isEnabled = false
            btn10.isEnabled = false
            btn11.isEnabled = false
            btn12.isEnabled = false
            btn13.isEnabled = false
            btn14.isEnabled = false
            btn15.isEnabled = false
            btn16.isEnabled = false
            //If it is the second image clicked, make the 1 second delay to give time for the player to remember, then call the match function
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.match()
            })
            //Otherwise, call the match function directly.
        } else {
            match()
        }
    }
    //Set function for the new game button.
    @IBAction func NewGameBtn(_ sender: Any) {
        //Show all the buttons with cover images.
        btn1.isHidden = false
        btn2.isHidden = false
        btn3.isHidden = false
        btn4.isHidden = false
        btn5.isHidden = false
        btn6.isHidden = false
        btn7.isHidden = false
        btn8.isHidden = false
        btn9.isHidden = false
        btn10.isHidden = false
        btn11.isHidden = false
        btn12.isHidden = false
        btn13.isHidden = false
        btn14.isHidden = false
        btn15.isHidden = false
        btn16.isHidden = false
        //Show the score label
        ScoreSymbol.isHidden = false
        //Hide the new game button until the next round is finished.
        newGameBtn.isHidden = true
        //Reset the first deck with all the images. And deck 2 as empty.
        deck1 = [#imageLiteral(resourceName: "Beauty"),#imageLiteral(resourceName: "fitty"),#imageLiteral(resourceName: "Happy"),#imageLiteral(resourceName: "Lazy"),#imageLiteral(resourceName: "MrW"),#imageLiteral(resourceName: "LadyW"),#imageLiteral(resourceName: "Sunny"),#imageLiteral(resourceName: "LittleGray"),#imageLiteral(resourceName: "Beauty"),#imageLiteral(resourceName: "fitty"),#imageLiteral(resourceName: "Happy"),#imageLiteral(resourceName: "Lazy"),#imageLiteral(resourceName: "MrW"),#imageLiteral(resourceName: "LadyW"),#imageLiteral(resourceName: "LittleGray"),#imageLiteral(resourceName: "Sunny")]
        deck2 = []
        //Reset the button array.
        btnArray = []
        //Reset the swicth.
        isItTheSecondImage = false
        //Reset the btnNumber.
        btnNumber = 0
        //Reset the score
        score = 0
        //Reset the number of consecutive matches.
        numberOfContinuos = 0
        //Call shuffle function to have a different game.
        shuffle()
        //Show the start score
        Score.text = String(score)
        //Enable all the buttons
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
        btn5.isEnabled = true
        btn6.isEnabled = true
        btn7.isEnabled = true
        btn8.isEnabled = true
        btn9.isEnabled = true
        btn10.isEnabled = true
        btn11.isEnabled = true
        btn12.isEnabled = true
        btn13.isEnabled = true
        btn14.isEnabled = true
        Score.isHidden = false
        btn15.isEnabled = true
        btn16.isEnabled = true
        //Set all the buttons' images to the cover image.
        btn1.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn2.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn3.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn4.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn5.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn6.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn7.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn8.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn9.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn10.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn11.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn12.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn13.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn14.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn15.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        btn16.setImage(#imageLiteral(resourceName: "images (1)"), for: UIControlState.normal)
        //Enable the give up button
        GiveUpBtn.isEnabled = true
        //If it is in the time mode, reset the total time to 70 seconds, start score to 100. Restart the timer, show the time labels.
        if modenum == 2{
            totalTime = 70
            score = 100
            TimeLable.isHidden = false
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NMViewController.couter), userInfo: nil, repeats: true)
        //If the two player mode is selected, reset the two players' score.
        } else if modenum == 3 {
            Score.isHidden = true
            player1Score = 0
            player2Score = 0
            Player1ScoreLable.text = String(player1Score)
            Player2ScoreLable.text = String(player2Score)
        }
    }
    //Set a function for the give up button.
    @IBAction func giveUpBtn(_ sender: Any) {
        //Show all the images on the buttons.
        btn1.setImage(deck2[0], for: UIControlState.normal)
        btn2.setImage(deck2[1], for: UIControlState.normal)
        btn3.setImage(deck2[2], for: UIControlState.normal)
        btn4.setImage(deck2[3], for: UIControlState.normal)
        btn5.setImage(deck2[4], for: UIControlState.normal)
        btn6.setImage(deck2[5], for: UIControlState.normal)
        btn7.setImage(deck2[6], for: UIControlState.normal)
        btn8.setImage(deck2[7], for: UIControlState.normal)
        btn9.setImage(deck2[8], for: UIControlState.normal)
        btn10.setImage(deck2[9], for: UIControlState.normal)
        btn11.setImage(deck2[10], for: UIControlState.normal)
        btn12.setImage(deck2[11], for: UIControlState.normal)
        btn13.setImage(deck2[12], for: UIControlState.normal)
        btn14.setImage(deck2[13], for: UIControlState.normal)
        btn15.setImage(deck2[14], for: UIControlState.normal)
        btn16.setImage(deck2[15], for: UIControlState.normal)
        //Disable the give up button
        GiveUpBtn.isEnabled = false
        //Disable all the buttons
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
        btn5.isEnabled = false
        btn6.isEnabled = false
        btn7.isEnabled = false
        btn8.isEnabled = false
        btn9.isEnabled = false
        btn10.isEnabled = false
        btn11.isEnabled = false
        btn12.isEnabled = false
        btn13.isEnabled = false
        btn14.isEnabled = false
        btn15.isEnabled = false
        btn16.isEnabled = false
        //Show the new game button
        newGameBtn.isHidden = false
        btn1.isHidden = false
        btn2.isHidden = false
        btn3.isHidden = false
        btn4.isHidden = false
        btn5.isHidden = false
        btn6.isHidden = false
        btn7.isHidden = false
        btn8.isHidden = false
        btn9.isHidden = false
        btn10.isHidden = false
        btn11.isHidden = false
        btn12.isHidden = false
        btn13.isHidden = false
        btn14.isHidden = false
        btn15.isHidden = false
        btn16.isHidden = false
        //If it is in the time mode, stop the timer and set the score to 0.
        if modenum == 2 {
            time.invalidate()
            score = 0
        //If it is in the two player mode, reset the score of the two players.
        } else if modenum == 3 {
            player2Score = 0
            player1Score = 0
            Player1ScoreLable.text = String(player1Score)
            Player2ScoreLable.text = String(player2Score)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //When forming the game, everything is hidden except for the start game button.
        //Shuffle when the game is started.
        shuffle()
        //Hide everything except the start button
        Player1Lable.isHidden = true
        Player2Lable.isHidden = true
        Player1ScoreLable.isHidden = true
        Player2ScoreLable.isHidden = true
        btn1.isHidden = true
        btn2.isHidden = true
        btn3.isHidden = true
        btn4.isHidden = true
        btn5.isHidden = true
        btn6.isHidden = true
        btn7.isHidden = true
        btn8.isHidden = true
        btn9.isHidden = true
        btn10.isHidden = true
        btn11.isHidden = true
        btn12.isHidden = true
        btn13.isHidden = true
        btn14.isHidden = true
        btn15.isHidden = true
        btn16.isHidden = true
        ScoreSymbol.isHidden = true
        Score.isHidden = true
        newGameBtn.isHidden = true
        GiveUpBtn.isHidden = true
        TimeLbl.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
