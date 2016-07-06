//
//  HistoryViewController.swift
//  RockPaperScissors
//
//  Created by Anna Rogers on 7/5/16.
//  Copyright © 2016 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var history = [RPSMatch]()
    
    override func viewDidLoad() {
//        link the view controller to the datasource and the delegate
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    
//    display the history of the app on the view
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return history.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "historyCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        print("cell", indexPath)
        let match = history[indexPath.row]
        
        cell.textLabel?.text = victoryStatusDescription(match)
        cell.detailTextLabel?.text = "\(match.p1) vs. \(match.p2)"

        return cell
    }
    
    func victoryStatusDescription(match: RPSMatch) -> String {
        
        if (match.p1 == match.p2) {
            return "Tie."
        } else if (match.p1.defeats(match.p2)) {
            return "Win!"
        } else {
            return "Loss."
        }
    }
    

    @IBAction func dismissHistory(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
