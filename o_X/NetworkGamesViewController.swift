//
//  NetworkGamesViewController.swift
//  o_X
//
//  Created by Enrique Pajuelo on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesViewController: UITableViewController {
    
    private var games: [OXGame] = []
    
    @IBAction func dismissButton(sender: AnyObject) {
        [self .dismissViewControllerAnimated(true, completion: nil)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OXGameController.sharedInstance.getGames(onCompletion: {games, error in
            if let availGames:[OXGame] = games {
                self.games = availGames
                self.tableView.reloadData()
            } else {
                print("Error Message")
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = games[indexPath.row].host
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.performSegueWithIdentifier("NetworktoBoard", sender: self)
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? BoardViewController {
            destinationVC.networkMode = true
        }
    }

}
