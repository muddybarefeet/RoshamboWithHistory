//
//  RockPaperScissorsViewController.swift
//  RockPaperScissors
//
//  Created by Gabrielle Miller-Messner on 10/30/14.
//  Copyright (c) 2014 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class RockPaperScissorsViewController: UIViewController {

    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    var match: RPSMatch!
    
    // Here is the history array which will hold the results of each match that is played in a session.
    var history = [RPSMatch]()

//    1. move is made by user and output passed to thrownDown
    @IBAction func makeYourMove(sender: UIButton) {
        print("RPS", sender)
        // The RPS enum holds a player's move
        switch (sender) {
        case self.rockButton:
            throwDown(RPS.Rock)
            
        case self.paperButton:
            throwDown(RPS.Paper)

        case self.scissorsButton:
            throwDown(RPS.Scissors)
        
        default:
            assert(false, "An unknown button is invoking makeYourMove()")
        }
    }
    
//    2. generate the computers turn and stores both turns in a struct (p1 and p2) and store in the match variable
    func throwDown (playersMove: RPS) {
        // The RPS enum generates the opponent's move
        let computersMove = RPS()
        
        // The RPSMatch struct stores the results of a match
        self.match = RPSMatch(p1: playersMove, p2: computersMove)
        
        // Here we add a match to the history array. 
        history.append(match)
        
        //Here are the 3 ways of presenting a View Controller
        
        // 1st Way: Programmatic View Controller Presentation
        if (playersMove == RPS.Rock) {
            // Get the storyboard and ResultViewController
            let storyboard = UIStoryboard (name: "Main", bundle: nil)
            let resultVC = storyboard.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
        
            // Communicate the match
            resultVC.match = self.match
            self.presentViewController(resultVC, animated: true, completion: nil)
        }
        
        // 2nd Way: Code plus Segue
        else if (playersMove == RPS.Paper) {
            performSegueWithIdentifier("throwDownPaper", sender: self)
        }
        
        // 3rd Way: Segue Only, No code!
        // But don't forget to implement prepareForSegue.
//        performSegueWithIdentifier("throwDownScissors", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showHistory" {
            print("show history")
            let controller = segue.destinationViewController as! HistoryViewController
            controller.history = history
        } else {
            //Notice that this code works for both Scissors and Paper
            let controller = segue.destinationViewController as! ResultViewController
            controller.match = self.match
        }
    }
   
    @IBAction func showHistory(sender: AnyObject) {
      //TODO: Present HistoryViewController
        print("see the history")
        var controller: HistoryViewController
        controller = storyboard?.instantiateViewControllerWithIdentifier("HistoryViewController") as! HistoryViewController
        controller.history = history
        presentViewController(controller, animated: true, completion: nil)
    }
    
}